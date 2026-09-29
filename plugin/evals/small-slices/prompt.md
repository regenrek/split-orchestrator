---
description: Three small, independent functions. Each is about as long as a brief for it would be, so delegating is optional. The plugin must not make the result worse.
expected_outcome: All three functions implemented and the full unittest suite passes.
model: opus
max_turns: 60
timeout_seconds: 1200
allowed_tools: [Read, Glob, Grep, Agent, Skill, TodoWrite]
tags: [regression]
---

The textkit package in this repository has three stub functions: `slugify` in textkit/slug.py, `top_words` in textkit/words.py and `truncate` in textkit/trim.py. Each docstring specifies the behaviour, and tests/ covers all three. Implement them so the whole test suite passes: `python3 -m unittest discover -s tests`.
