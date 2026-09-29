---
type: regex
target:
  source: file
  path: greet.py
pattern: 'def format_name\(first, last\):[\s\S]*\+ format_name\(first, last\) \+'
---
