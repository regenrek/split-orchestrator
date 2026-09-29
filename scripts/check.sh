#!/usr/bin/env bash
# Validates the plugin and marketplace, lints the shell scripts, and checks that
# the worker model and effort agree everywhere they're written down.
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root"

failures=0
fail() {
  echo "✗ $*" >&2
  failures=$((failures + 1))
}

claude plugin validate plugin --strict
claude plugin validate . --strict

scripts=(scripts/*.sh hosts/bb/install.sh plugin/evals/fixtures/*.sh plugin/evals/*/scaffold.sh)
if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "${scripts[@]}"
else
  echo "shellcheck not installed; skipping shell lint" >&2
fi
for script in "${scripts[@]}"; do
  [[ -x "$script" ]] || fail "$script is not executable"
done

agent=plugin/agents/implementer.md
model=$(sed -n 's/^model:[[:space:]]*//p' "$agent")
effort=$(sed -n 's/^effort:[[:space:]]*//p' "$agent")
[[ "$model" == sonnet ]] || fail "$agent: expected model sonnet, found '$model'"

grep -q -- "--reasoning-level $effort" hosts/bb/instructions.md ||
  fail "hosts/bb/instructions.md doesn't spawn workers with --reasoning-level $effort"
grep -q "effort = \"$effort\"" hosts/herdr/profiles.toml ||
  fail "hosts/herdr/profiles.toml doesn't set effort = \"$effort\""
for doc in plugin/rules/coordinator.md plugin/skills/orchestrate/SKILL.md README.md; do
  grep -q "Sonnet, $effort effort" "$doc" || fail "$doc doesn't say 'Sonnet, $effort effort'"
done

if ((failures > 0)); then
  echo "$failures check(s) failed" >&2
  exit 1
fi
echo "✔ All checks passed"
