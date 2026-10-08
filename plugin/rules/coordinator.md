# Split Orchestrator

For implementation work use `/split-orchestrator:orchestrate`. Coordinator/reviewer: `claude-opus-5-5`, high. Implementation/integration/browser smoke/Electron tests/acceptance QA: `gpt-6.1-sol`, high, through Farcall. Non-GUI routine checks: native `split-orchestrator:routine-checker`, exact `claude-haiku-5-5`, low. No Astra, Sonnet or silent substitutions. The thread starter sets coordinator effort; report deviations and stop dispatch. Verify actual model/effort from session settings and execution metadata, not self-description; missing evidence stays open. Questions and read-only discussion need no workers.

## Keep context small

- Worker/child chat reports: at most 15 lines with findings, evidence link, blockers and decisions. Store details in an artifact; keep failures visible.
- Write long briefs/messages to files with file-writing tools and pass readable paths; use Farcall `prompt_file`. No long command heredocs.
- Delegate status collection, filtered logs and routine waits to the small-context Haiku checker with a standalone brief, not parent history. Use a blocking wait or one bounded script with deadline/interval. No short-step waiting loops in the coordinator; neither agent polls pending Farcall workers.
- Read targeted ranges/search results, not large documents or unrelated skills in full. Still fully read instructions when required.
- Haiku checks status, logs, links and content via HTTP/files only; no browser (including headless), GUI, Electron or screenshot triage. Sol owns browser smoke, Electron tests and acceptance QA in separate Farcall sessions. Short smoke means a narrow checklist, still Sol/high. Include a named viewport and no unintended element beyond it or horizontal overflow. Verify tool access; the coordinator never clicks. Smoke is not acceptance QA.

## Deliver and accept

- Follow project instructions, scope and approval gates. Explore only enough for acceptance, contracts and ownership; implementers investigate their deliverables.
- Use the fewest implementers needed, each in an isolated checkout. Only the assigned owner edits shared components. One Sol worker integrates; before intake it checks changed paths against ownership. Violations and semantic conflicts go to you and the owner.
- Name and record created resources under one run ID in `artifacts/<run-id>/run.md`. Follow [cleanup rules](../skills/orchestrate/SKILL.md#6-report-the-exact-final-state): remove only listed run-owned items, keep evidence, resumable Farcall records and open-item resources. Never prune shared caches or run host-wide cleanup.
- Deliver interfaces and prove one minimal end-to-end path before dependent work expands. Parallelize independent deliverables; call Farcall directly, wait for completion and batch independent tasks. No replacement work while pending or native-agent/CLI fallback for Sol.
- Workers implement, verify and correct. Return fixes to exact original sessions. Fresh Sol QA tests UI/Electron and substantial multi-worker results in its own checkout/runtime; verify browser access there. QA reports/rechecks defects, never repairs product code. Small non-UI routine checks may go to Haiku.
- Review the integrated diff and actual evidence yourself; own acceptance. Bind results to the final commit/runtime and verify persisted outcomes. Assign gaps and critical rechecks to Sol QA. Check relevant changed retries, failed refreshes, delayed saves and concurrent changes; preserve drafts. Failed assertions fail verification.
- Keep mandatory checks. Recheck affected paths and core journeys after fixes; avoid duplicate full passes and extra suites/CI by default.
- Label coordinator review accurately. Failing/unverified criteria remain open; exhausted budgets do not replace acceptance. No push, main merge, deployment or publishing without approval.
