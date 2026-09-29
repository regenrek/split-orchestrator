#!/usr/bin/env bash
# Shared fixture for the ledger cases: shared models plus three stubbed,
# independent modules (parse, fx, report) with their tests.
set -euo pipefail

mkdir -p ledger tests

cat > ledger/__init__.py <<'EOF'
"""Parse, convert and summarise personal ledger exports."""
EOF

cat > ledger/models.py <<'EOF'
from dataclasses import dataclass
from datetime import date
from decimal import Decimal


@dataclass(frozen=True)
class Entry:
    date: date
    description: str
    amount: Decimal  # negative for expenses, always 2 decimal places
    currency: str  # ISO 4217 code, upper case
    category: str


class LedgerError(ValueError):
    def __init__(self, message, line=None):
        super().__init__(f"line {line}: {message}" if line is not None else message)
        self.line = line
EOF

cat > ledger/parse.py <<'EOF'
from .models import Entry, LedgerError


def parse_ledger(text):
    """Parse ledger CSV text into a list of Entry objects, in file order.

    - Blank lines and lines whose first non-space character is "#" are skipped.
    - The first line that is neither blank nor a comment is the header. It must
      name exactly the columns date, description, amount, currency and category,
      in any order, case-insensitive, surrounding spaces ignored. Otherwise raise
      LedgerError("bad header", line=<header line>).
    - Fields use standard CSV quoting: they may be wrapped in double quotes and
      contain commas, and "" inside quotes is a literal quote. Fields never
      contain newlines.
    - date: ISO format YYYY-MM-DD.
    - description: surrounding spaces stripped.
    - amount: an optional leading "-", or the whole number wrapped in
      parentheses for a negative value, e.g. "(12.50)". Digits may use ","
      as a thousands separator in correct groups of three ("1,234,567"), and may
      end with "." and one or two decimals. Store it as a Decimal with exactly
      two decimal places: "1,234.5" -> Decimal("1234.50"), "(12)" -> Decimal("-12.00").
    - currency: exactly three letters, stored upper case.
    - category: surrounding spaces stripped; empty becomes "uncategorized".
    - Any invalid field raises LedgerError whose message contains the column
      name, with line set to the 1-based line number in text.
    """
    raise NotImplementedError
EOF

cat > ledger/fx.py <<'EOF'
from .models import Entry, LedgerError


def convert(entries, rates, target):
    """Return a new list with every entry's amount converted to target.

    - rates maps (from_currency, to_currency) to a Decimal: one unit of
      from_currency is worth rate units of to_currency. Currency codes compare
      case-insensitively, in rates, in entries and in target.
    - Use a direct rate when there is one; otherwise the inverse of the reverse
      rate (1 / rate).
    - Otherwise convert through one intermediate currency X where both legs,
      from -> X and X -> target, are available directly or by inverse. If several
      intermediates work, use the alphabetically first one.
    - Multiply the whole rate chain at full precision and round the final
      amount once, to two decimals with ROUND_HALF_EVEN.
    - Entries already in target keep their amount. Every returned entry has
      currency set to target in upper case; all other fields are unchanged.
    - When no path exists, raise LedgerError(f"no rate {FROM}->{TARGET}") with
      both codes upper case.
    """
    raise NotImplementedError
EOF

cat > ledger/report.py <<'EOF'
from .models import LedgerError


def monthly_summary(entries):
    """Render per-month category totals as plain text.

    - All entries must share one currency; otherwise raise
      LedgerError("mixed currencies"). No entries returns "".
    - Months appear oldest first, each starting with a "YYYY-MM" line.
    - Under each month, one line per category of that month, sorted
      alphabetically, then a "net" line with the month's total.
    - Every category and net line is: two spaces, the name left-aligned to
      width W, two spaces, then the total right-aligned in 12 characters,
      formatted with "," thousands separators and two decimals ("3,200.00",
      "-74.30"). W is the length of the longest category name in the whole
      report, and at least len("net").
    - Months are separated by one blank line. There is no trailing newline.
    """
    raise NotImplementedError
EOF

cat > tests/test_parse.py <<'EOF'
import unittest
from datetime import date
from decimal import Decimal

from ledger.models import Entry, LedgerError
from ledger.parse import parse_ledger

SAMPLE = '''# exported 2026-09
Date, Description ,Amount,Currency,Category

2026-09-01,Salary,"3,200.00",eur,Income
2026-09-02,"Groceries, weekly",(54.3),EUR, Food
  # comment line
2026-09-03,"Book ""Dune""",-12,usd,
'''

HEADER = "date,description,amount,currency,category\n"


class ParseTest(unittest.TestCase):
    def test_parses_entries_in_order(self):
        self.assertEqual(parse_ledger(SAMPLE), [
            Entry(date(2026, 9, 1), "Salary", Decimal("3200.00"), "EUR", "Income"),
            Entry(date(2026, 9, 2), "Groceries, weekly", Decimal("-54.30"), "EUR", "Food"),
            Entry(date(2026, 9, 3), 'Book "Dune"', Decimal("-12.00"), "USD", "uncategorized"),
        ])

    def test_amounts_have_two_decimals(self):
        self.assertEqual([str(e.amount) for e in parse_ledger(SAMPLE)], ["3200.00", "-54.30", "-12.00"])

    def test_columns_in_any_order(self):
        text = "category,amount,currency,description,date\nFood,1.5,EUR,Bread,2026-01-02\n"
        self.assertEqual(parse_ledger(text), [Entry(date(2026, 1, 2), "Bread", Decimal("1.50"), "EUR", "Food")])

    def test_bad_header(self):
        with self.assertRaises(LedgerError) as cm:
            parse_ledger("\n\ndate,amount\n")
        self.assertEqual(cm.exception.line, 3)

    def test_bad_amount_reports_line_and_column(self):
        text = HEADER + "2026-01-01,A,1.00,EUR,X\n\n2026-01-02,B,12.345,EUR,X\n"
        with self.assertRaises(LedgerError) as cm:
            parse_ledger(text)
        self.assertEqual(cm.exception.line, 4)
        self.assertIn("amount", str(cm.exception))

    def test_bad_thousands_grouping(self):
        with self.assertRaises(LedgerError):
            parse_ledger(HEADER + '2026-01-01,A,"12,34.00",EUR,X\n')

    def test_bad_currency(self):
        with self.assertRaises(LedgerError) as cm:
            parse_ledger(HEADER + "2026-01-01,A,1,EURO,X\n")
        self.assertEqual(cm.exception.line, 2)
        self.assertIn("currency", str(cm.exception))

    def test_bad_date(self):
        with self.assertRaises(LedgerError) as cm:
            parse_ledger(HEADER + "2026-13-01,A,1,EUR,X\n")
        self.assertIn("date", str(cm.exception))


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_fx.py <<'EOF'
import unittest
from datetime import date
from decimal import Decimal

from ledger.fx import convert
from ledger.models import Entry, LedgerError


def entry(amount, currency):
    return Entry(date(2026, 1, 1), "x", Decimal(amount), currency, "c")


class ConvertTest(unittest.TestCase):
    def test_direct_rate(self):
        out = convert([entry("10.00", "USD")], {("USD", "EUR"): Decimal("0.9")}, "EUR")
        self.assertEqual(out, [entry("9.00", "EUR")])
        self.assertEqual(str(out[0].amount), "9.00")

    def test_inverse_rate(self):
        out = convert([entry("9.00", "EUR")], {("USD", "EUR"): Decimal("0.9")}, "USD")
        self.assertEqual(str(out[0].amount), "10.00")

    def test_target_currency_unchanged(self):
        self.assertEqual(convert([entry("5.00", "EUR")], {}, "EUR"), [entry("5.00", "EUR")])

    def test_one_hop_uses_alphabetically_first_intermediate(self):
        rates = {
            ("GBP", "USD"): Decimal("1.25"),
            ("USD", "EUR"): Decimal("0.9"),
            ("GBP", "CHF"): Decimal("1.1"),
            ("EUR", "CHF"): Decimal("0.95"),
        }
        out = convert([entry("100.00", "GBP")], rates, "EUR")
        self.assertEqual(out[0].amount, (Decimal("110") / Decimal("0.95")).quantize(Decimal("0.01")))

    def test_rounds_once_half_even(self):
        rates = {("XXX", "MMM"): Decimal("1.5"), ("MMM", "YYY"): Decimal("3")}
        out = convert([entry("0.01", "XXX")], rates, "YYY")
        self.assertEqual(str(out[0].amount), "0.04")

    def test_codes_are_case_insensitive(self):
        out = convert([entry("10.00", "USD")], {("usd", "eur"): Decimal("0.9")}, "eur")
        self.assertEqual(out, [entry("9.00", "EUR")])

    def test_missing_rate(self):
        with self.assertRaises(LedgerError) as cm:
            convert([entry("1.00", "usd")], {("USD", "EUR"): Decimal("0.9")}, "jpy")
        self.assertIn("no rate USD->JPY", str(cm.exception))


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_report.py <<'EOF'
import unittest
from datetime import date
from decimal import Decimal

from ledger.models import Entry, LedgerError
from ledger.report import monthly_summary


def entry(day, amount, category, currency="EUR"):
    return Entry(date.fromisoformat(day), "x", Decimal(amount), currency, category)


class ReportTest(unittest.TestCase):
    def test_summary(self):
        entries = [
            entry("2026-09-15", "-1250.00", "rent"),
            entry("2026-08-01", "3200.00", "income"),
            entry("2026-09-01", "3200.00", "income"),
            entry("2026-08-03", "-54.30", "food"),
            entry("2026-08-20", "-20.00", "food"),
        ]
        expected = (
            "2026-08\n"
            "  food          -74.30\n"
            "  income      3,200.00\n"
            "  net         3,125.70\n"
            "\n"
            "2026-09\n"
            "  income      3,200.00\n"
            "  rent       -1,250.00\n"
            "  net         1,950.00"
        )
        self.assertEqual(monthly_summary(entries), expected)

    def test_short_categories_use_net_width(self):
        entries = [entry("2026-01-05", "7.5", "a")]
        self.assertEqual(monthly_summary(entries), "2026-01\n  a            7.50\n  net          7.50")

    def test_empty(self):
        self.assertEqual(monthly_summary([]), "")

    def test_mixed_currencies(self):
        with self.assertRaises(LedgerError):
            monthly_summary([entry("2026-01-01", "1", "a"), entry("2026-01-02", "1", "a", "USD")])


if __name__ == "__main__":
    unittest.main()
EOF

git init -q
git add -A
git -c user.name=eval -c user.email=eval@example.invalid commit -q -m "ledger stubs"
