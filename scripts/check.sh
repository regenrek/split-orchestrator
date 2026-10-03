#!/usr/bin/env bash
# Local packaging and host-cleanup checks. No model calls.
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root"

claude plugin validate plugin --strict
claude plugin validate . --strict

scripts=(scripts/*.sh hosts/bb/install.sh)
if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "${scripts[@]}"
else
  echo "shellcheck not installed; skipping shell lint" >&2
fi
for script in "${scripts[@]}"; do
  [[ -x "$script" ]] || { echo "$script is not executable" >&2; exit 1; }
  bash -n "$script"
done
python3 scripts/check_repository.py
