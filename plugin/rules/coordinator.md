# Split Orchestrator

For implementation use `/split-orchestrator:orchestrate`. Coordinator: `claude-opus-5-5`, high, set by the thread starter. Sol via Farcall: `gpt-6.1-sol`, high for implementation/integration/acceptance; medium only for fixed-checklist browser/Electron smoke. Non-GUI routine checker: `claude-haiku-5-5`, low. Verify actual session/execution model and effort, not self-description. Report missing evidence or mismatches and stop dispatch; no silent substitutions, Astra or Sonnet. Discussion needs no workers.

## Keep coordinators small

- Prepare a handoff near 150k context tokens; rotate near 200k, after a completed milestone or at least daily during active work, whichever comes first. These are unvalidated starting values. Start fresh with a 2–5k-token file handoff; never resume/fork the large transcript.
- Keep authoritative state in repo/planning files. Follow the [continuity contract](../skills/orchestrate/references/coordination.md): goals, task IDs, owners, open session/delegation IDs, linked decisions, blockers, next steps and exact revisions. Exactly one successor owns dispatch. Preserve pending Farcall waits; late results use durable task IDs. Report blocked rotation rather than claiming success.
- Manage 3–5 active streams; queue more. Independent workers may stay parallel. Results go to files. Wake immediately only for blockers, decisions or acceptance-ready results; batch other progress by milestone or every 10–15 minutes. No acknowledgement-only messages or broadcasts to unaffected threads.
- Chat reports: at most 15 lines, findings/blockers/decisions and detail-file link. Pass long briefs by readable path (`prompt_file` for Farcall), not command heredocs. Read targeted ranges/searches; fully read required instructions.
- Haiku handles status, filtered logs, HTTP/file checks and bounded routine waits. No browser/GUI/Electron or screenshot triage. Use blocking waits or one bounded script, no short-step coordinator loops; neither agent polls pending Farcall workers.

## Deliver and accept

- Follow project instructions, scope and approval gates. Set observable acceptance, contracts and owners; implementers investigate details. Use few implementers with isolated checkouts. Shared components have one owner; one Sol integrator checks changed paths before intake. Escalate ownership/semantic conflicts to you and the owner.
- Deliver interfaces and prove a minimal end-to-end path before dependent work expands. Batch independent Farcall tasks and wait directly. No replacement work while pending or native-agent/CLI fallback for Sol. Return fixes to exact original sessions.
- Sol browser/Electron smoke and fresh acceptance QA have separate sessions/checkouts/runtime state with verified tool access. Assert viewport bounds/no unintended horizontal overflow. Sample early medium smoke against high acceptance on the same cases; if medium finds substantially fewer issues, return smoke to high and record why. QA reports/rechecks, never repairs product code. The coordinator never clicks; smoke is not acceptance.
- Review integrated diff and evidence yourself, tied to final commit/runtime and persisted outcomes. Assign live gaps to Sol QA. Check changed retries, failed refreshes, delayed saves and concurrent changes; preserve drafts. Failed assertions fail verification. Keep mandatory checks; recheck affected paths/core journeys, without duplicate full passes or extra suites/CI by default.
- Record created resources under one run ID in `artifacts/<run-id>/run.md`. Follow [cleanup](../skills/orchestrate/SKILL.md#6-report-the-exact-final-state): only listed run-owned items, retaining evidence/resumable records/open-item resources. Never prune shared caches or run host-wide cleanup.
- Label coordinator review accurately. Failing/unverified criteria stay open; exhausted budgets do not replace acceptance. No push, main merge, deployment or publication without approval. The plugin does not change user configuration.
