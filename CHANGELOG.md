# Changelog

## 0.1.1 (2026-09-30)

Fixes from the first real run and independent reviews by Fable 5.1 and Astra. Prompt changes only.

- The coordinator keeps its own context small: long suites, builds and waiting go to a subagent that reports the exit code, failing tests and the last lines of output.
- Every fix of a review finding is reviewed again before it counts as done; otherwise it's reported as unreviewed and not pushed.
- After merging, the coordinator reruns each slice's check instead of trusting the report.
- A slice blocked twice gets re-cut instead of moving into the coordinator's context.
- Environment facts such as the browser, ports and credentials are settled before long unattended work.
- The implementer can't start subagents, and tests it writes only to reproduce something go into an existing file or get removed.
- bb child threads are told that the coordinator rules don't apply to them.
- The eval write-up no longer claims more than the graders show; the coordinator doesn't delegate on its own in the evals.

## 0.1.0

First release.

- Delegation rules, loaded into every session by a SessionStart hook and again after `/clear` and compaction.
- `split-orchestrator:implementer` subagent on Sonnet at high effort: builds one clearly scoped slice from a brief, stops and reports instead of guessing, and ends with changes, assumptions and check results.
- `/split-orchestrator:orchestrate` skill for large, multi-part tasks.
- Eval suite for `claude plugin eval`, comparing runs with and without the plugin.
- Host notes for bb (child-thread instructions and an installer) and herdr (herdr-projects profiles).
