#!/usr/bin/env bash
# Seeds one small module with a function to rename.
set -euo pipefail

cat > greet.py <<'EOF'
def fmt(first, last):
    return f"{last.upper()}, {first}"


def greet(first, last):
    return "Hello, " + fmt(first, last) + "!"
EOF

git init -q
git add -A
git -c user.name=eval -c user.email=eval@example.invalid commit -q -m "greet module"
