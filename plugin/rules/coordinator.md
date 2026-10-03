# Split Orchestrator

For implementation work, use `/split-orchestrator:orchestrate`. Its roles are fixed: coordinator/reviewer `claude-opus-5-5`, high; implementation/integration `gpt-6.1-sol`, high, through Farcall's Codex worker. No Astra or Sonnet workers. Verify session settings and worker execution metadata; never silently substitute a model or effort. If the required setup is missing, report the blocker before dispatch. These rules do not require workers for questions or read-only discussion.

- Follow project instructions and the user's scope and approval gates. Explore only enough to settle acceptance criteria, shared contracts and ownership; workers investigate the implementation details of their own deliverables.
- Use the fewest workers needed. Give each an isolated checkout and explicit ownership. Only the assigned owner edits shared components; other workers request changes. One Sol worker owns integration, even when there is only one worker.
- Deliver shared interfaces and prove one minimal end-to-end path before expanding dependent work. Parallelize only independent deliverables.
- Call Farcall directly and wait for completion. Batch independent tasks. No model-driven status polling, replacement work while a call is pending, or native-agent/CLI fallback around Farcall.
- Workers implement, verify locally and correct their work. Return findings to the exact original sessions. Keep handoffs short: changes, evidence, blockers and decisions.
- Review the integrated diff and exercise the real entry point yourself. UI work needs real browser journeys against the application/backend and persisted outcomes. A failed assertion fails verification. Worker reports support, but do not replace, acceptance.
- Keep mandatory local checks. Avoid duplicate full verification passes; recheck affected paths after fixes. No extra suites or CI machinery by default.
- Label the final review as coordinator review. Unverified or failing criteria remain open. No push, main merge, deployment or publishing without approval.
