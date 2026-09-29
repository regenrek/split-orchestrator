---
description: The user asks for one subagent per module. With the plugin the slices go to Sonnet implementers; without it they go to general-purpose subagents on the main model. Compares quality and cost of the same delegation.
expected_outcome: parse, fx and report implemented by subagents, and the coordinator ran the full suite on the integrated result.
model: opus
max_turns: 80
timeout_seconds: 1800
allowed_tools: [Read, Glob, Grep, Agent, Skill, TodoWrite]
tags: [delegation, cost]
---

The ledger package in this repository has three unimplemented modules: ledger/parse.py (`parse_ledger`), ledger/fx.py (`convert`) and ledger/report.py (`monthly_summary`). Their docstrings are the spec, ledger/models.py holds the shared types, and tests/ covers all three.

Hand each module to its own subagent so they're built in parallel, then run the whole test suite yourself on the combined result: `python3 -m unittest discover -s tests`.
