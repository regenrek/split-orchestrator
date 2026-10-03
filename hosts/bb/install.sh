#!/usr/bin/env bash
# Remove the legacy split-orchestrator block from bb custom instructions.
# Dry run by default; --apply writes the result. Other instructions are kept.
#
#   hosts/bb/install.sh
#   hosts/bb/install.sh --apply
set -euo pipefail

apply=false
for arg in "$@"; do
  case "$arg" in
    --apply) apply=true ;;
    -h | --help) sed -n '2,6p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

current=$(bb instructions get)
start='<!-- split-orchestrator:start -->'
end='<!-- split-orchestrator:end -->'
# Refuse malformed markers rather than discarding somebody else's instructions.
cleaned=$(printf '%s\n' "$current" | awk -v s="$start" -v e="$end" '
  $0 == s { if (inside) bad = 1; inside = 1; next }
  $0 == e { if (!inside) bad = 1; inside = 0; next }
  !inside { kept[++n] = $0 }
  END {
    if (bad || inside) exit 2
    for (i = 1; i <= n; i++) print kept[i]
  }
') || { echo "Malformed split-orchestrator markers; no instructions changed." >&2; exit 1; }

if ! $apply; then
  printf '%s\n' "$cleaned"
  echo "Dry run. Use --apply to remove the old block." >&2
elif [[ "$cleaned" == "$current" ]]; then
  echo "No legacy block found; instructions unchanged."
elif [[ -n "$cleaned" ]]; then
  bb instructions set "$cleaned" >/dev/null
  echo "Legacy split-orchestrator block removed."
else
  bb instructions clear >/dev/null
  echo "Legacy split-orchestrator block removed."
fi
