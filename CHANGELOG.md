# Changelog

## 0.3.1 (unreleased)

- Keep coordinator context small: 15-line worker summaries, linked detail files, targeted reads and bounded routine waits. Farcall completion waits remain direct.
- Add an exact `claude-haiku-5-5` / low routine-check subagent for smoke checks, logs and layout triage. Sol high retains acceptance QA; the coordinator reviews evidence without browser clicks. Verify actual model/effort and report deviations from starter-set coordinator high.

- Track run-owned resources and clean them up at close, preserving evidence, resume records and open items; use local worker clones without copying dependencies or build output.

## 0.3.0 (2026-10-03)

- Add fresh Sol-high QA sessions for live browser/Electron checks of the integrated application. QA reports and rechecks defects; original implementation sessions repair them. Opus reviews the diff and actual evidence and owns acceptance, without routinely duplicating QA journeys.
- Make applicable changed-retry, failed-refresh, delayed-save and concurrent-status cases explicit. Verify persisted outcomes and preserve unsaved drafts.
- Require the integrator to check changed paths against ownership before intake and escalate semantic conflicts.
- Tie acceptance evidence to the final integrated commit and running instance, with reproducible test data and working tools in the actual QA session. Recheck affected paths and core journeys after fixes.
- Keep a fresh reviewer optional. Budget exhaustion reports open criteria; it never replaces acceptance.
- Refresh the workflow diagram, setup and verification notes. See [verification](docs/evaluation.md) for the release smoke test and its limits.

## 0.2.0 (2026-10-03)

Published to the marketplace's main branch; no separate release tag.

- Replace the native Sonnet implementer with `gpt-6.1-sol`, high, through Farcall. Coordinator/reviewer is `claude-opus-5-5`, high. No Astra or silent substitutions.
- Assign one Sol worker exclusive integration responsibility. Use isolated checkouts, shared-component ownership and the fewest workers needed.
- Deliver shared contracts and a minimal real end-to-end path before expanding dependent work.
- Use direct Farcall completion waits, batch independent tasks and return corrections to exact original sessions.
- Require coordinator acceptance of the integrated application and persisted outcomes, including relevant failure, retry and conflict behavior. Keep failed or unverified criteria open.
- Verify actual settings where metadata supports it; distinguish requested settings from independently reported model identity.
- Make Farcall a required separate installation. Retire native host-worker profiles and the active Sonnet eval suite; preserve the old results as historical evidence.
- Refresh setup, examples and the workflow diagram. The bb helper now only removes the old global instruction block.


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
