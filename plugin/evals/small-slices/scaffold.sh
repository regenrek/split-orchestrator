#!/usr/bin/env bash
# Seeds a small Python package with three stubbed functions and their tests.
set -euo pipefail

mkdir -p textkit tests

cat > textkit/__init__.py <<'EOF'
"""Small text helpers."""
EOF

cat > textkit/slug.py <<'EOF'
def slugify(text, max_length=None):
    """Turn text into a URL slug.

    - Lowercase, and transliterate accented letters to ASCII ("Café" -> "cafe").
      Drop characters that have no ASCII form.
    - Replace every run of characters that are not a-z or 0-9 with a single "-".
    - Strip leading and trailing "-".
    - With max_length, cut the slug to at most max_length characters on a "-"
      boundary, so no word is split. If the first word alone is longer than
      max_length, cut that word at max_length.
    - Return "" when nothing is left.
    """
    raise NotImplementedError
EOF

cat > textkit/words.py <<'EOF'
def top_words(text, n):
    """Return the n most frequent words as (word, count) tuples.

    - Words are runs of letters, digits and apostrophes; matching is
      case-insensitive and results are lowercase.
    - Apostrophes at the start or end of a word are not part of it
      ("'tis" -> "tis", "dogs'" -> "dogs"); inside a word they stay ("don't").
    - Sort by count, highest first, then alphabetically.
    - n <= 0 returns []. Fewer than n distinct words returns all of them.
    """
    raise NotImplementedError
EOF

cat > textkit/trim.py <<'EOF'
def truncate(text, width, placeholder="…"):
    """Shorten text to at most width characters.

    - Return text unchanged when len(text) <= width.
    - Otherwise return the longest prefix that ends at a word boundary
      (before whitespace), with trailing whitespace removed, followed by
      placeholder, so that the result is at most width characters.
    - If not even the first word fits, cut the text itself at
      width - len(placeholder) characters and append placeholder.
    - Raise ValueError when width < len(placeholder).
    """
    raise NotImplementedError
EOF

cat > tests/test_slug.py <<'EOF'
import unittest

from textkit.slug import slugify


class SlugifyTest(unittest.TestCase):
    def test_basic(self):
        self.assertEqual(slugify("Hello, World!"), "hello-world")

    def test_accents(self):
        self.assertEqual(slugify("Café au lait"), "cafe-au-lait")

    def test_collapses_and_strips(self):
        self.assertEqual(slugify("  --Foo___bar--  "), "foo-bar")

    def test_max_length_on_word_boundary(self):
        self.assertEqual(slugify("the quick brown fox", max_length=13), "the-quick")

    def test_max_length_long_first_word(self):
        self.assertEqual(slugify("Supercalifragilistic", max_length=5), "super")

    def test_empty(self):
        self.assertEqual(slugify("¿?¡!"), "")


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_words.py <<'EOF'
import unittest

from textkit.words import top_words


class TopWordsTest(unittest.TestCase):
    def test_counts_and_order(self):
        text = "The cat and the hat. THE end, and the cat."
        self.assertEqual(top_words(text, 3), [("the", 4), ("and", 2), ("cat", 2)])

    def test_apostrophes(self):
        text = "Don't stop. 'Tis the dogs' don't"
        self.assertEqual(top_words(text, 2), [("don't", 2), ("dogs", 1)])

    def test_n_larger_than_vocabulary(self):
        self.assertEqual(top_words("b a b", 10), [("b", 2), ("a", 1)])

    def test_non_positive_n(self):
        self.assertEqual(top_words("a b c", 0), [])


if __name__ == "__main__":
    unittest.main()
EOF

cat > tests/test_trim.py <<'EOF'
import unittest

from textkit.trim import truncate


class TruncateTest(unittest.TestCase):
    def test_fits(self):
        self.assertEqual(truncate("short text", 20), "short text")

    def test_word_boundary(self):
        self.assertEqual(truncate("The quick brown fox", 12), "The quick…")

    def test_custom_placeholder(self):
        self.assertEqual(truncate("The quick brown fox", 14, placeholder="..."), "The quick...")

    def test_first_word_too_long(self):
        self.assertEqual(truncate("Extraordinary claims", 6), "Extra…")

    def test_width_too_small(self):
        with self.assertRaises(ValueError):
            truncate("abc", 2, placeholder="...")


if __name__ == "__main__":
    unittest.main()
EOF

git init -q
git add -A
git -c user.name=eval -c user.email=eval@example.invalid commit -q -m "textkit stubs"
