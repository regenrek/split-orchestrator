---
description: A two-line rename. Delegating it would only add cost, so the coordinator should do it itself.
expected_outcome: The function is renamed at its definition and call site, with no implementer subagent involved.
model: opus
max_turns: 15
allowed_tools: [Read, Glob, Grep, Agent, Skill]
tags: [restraint]
---

In greet.py, rename the function `fmt` to `format_name` and update its call site in the same file.
