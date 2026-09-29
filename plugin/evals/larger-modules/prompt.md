---
description: Three independent modules, each clearly bigger than a brief for it. With the plugin, the coordinator should hand them to implementers, then run the whole suite on the integrated result.
expected_outcome: parse, fx and report implemented, the full unittest suite passes, and the coordinator ran it after the implementers finished.
model: opus
max_turns: 80
timeout_seconds: 1800
allowed_tools: [Read, Glob, Grep, Agent, Skill, TodoWrite]
tags: [delegation]
---

The ledger package in this repository has three unimplemented modules: ledger/parse.py (`parse_ledger`), ledger/fx.py (`convert`) and ledger/report.py (`monthly_summary`). Their docstrings are the spec, ledger/models.py holds the shared types, and tests/ covers all three. Implement the three modules so the whole test suite passes: `python3 -m unittest discover -s tests`.
