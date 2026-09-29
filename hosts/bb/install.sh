#!/usr/bin/env bash
# Adds the split-orchestrator child-thread rules to bb's custom instructions,
# or updates them in place. bb's `instructions set` replaces the whole text,
# so this keeps everything outside the split-orchestrator block. Dry run by
# default.
#
#   hosts/bb/install.sh            print the resulting instructions
#   hosts/bb/install.sh --apply    write them to bb
#   hosts/bb/install.sh --remove   print the instructions without the block
#   hosts/bb/install.sh --remove --apply
set -euo pipefail

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
start='<!-- split-orchestrator:start -->'
end='<!-- split-orchestrator:end -->'
limit=4096

apply=false
remove=false
for arg in "$@"; do
  case "$arg" in
    --apply) apply=true ;;
    --remove) remove=true ;;
    -h | --help)
      sed -n '2,10p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "unknown option: $arg" >&2
      exit 2
      ;;
  esac
done

if ! command -v bb >/dev/null 2>&1; then
  echo "bb CLI not found on PATH" >&2
  exit 1
fi

current=$(bb instructions get)

# Everything except an existing split-orchestrator block, without trailing blank lines.
rest=$(printf '%s\n' "$current" | awk -v s="$start" -v e="$end" '
  $0 == s { skip = 1; next }
  $0 == e { skip = 0; next }
  !skip { lines[++n] = $0 }
  END {
    while (n > 0 && lines[n] ~ /^[[:space:]]*$/) n--
    for (i = 1; i <= n; i++) print lines[i]
  }')

if $remove; then
  new=$rest
else
  block="$start"$'\n'"$(cat "$here/instructions.md")"$'\n'"$end"
  if [[ -n "$rest" ]]; then
    new="$rest"$'\n\n'"$block"
  else
    new=$block
  fi
fi

length=${#new}
if ((length > limit)); then
  echo "The instructions would be $length characters; bb allows $limit." >&2
  exit 1
fi

if ! $apply; then
  printf '%s\n' "$new"
  echo "--- dry run: $length/$limit characters. Re-run with --apply to write." >&2
  exit 0
fi

if [[ -n "$new" ]]; then
  bb instructions set "$new" >/dev/null
else
  bb instructions clear >/dev/null
fi
echo "bb custom instructions updated ($length/$limit characters)."
