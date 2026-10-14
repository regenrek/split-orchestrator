# Changelog

## 0.3.11 (2026-10-14)

- Where the tier requires diff review, Astra is the diff reviewer for Opus-built non-UI slices. The diff reviewer runs the affected tests at the reviewed head; worker-reported green alone is insufficient. New art-content class: no diff review of binary assets; review import, bake and build scripts; QA by captures in the running build.
- Only product corrections after review or QA count as rounds; owner fixes to tests, test contracts, fixtures, harness and environment are self-fixes bounded by the reserve. A stream already at the limit when the rules change gets one recheck.
- Codex roles default to the fast service tier; record the actual tier. A host that cannot select the default effort uses the next higher one, recorded.
- Native or host-thread worker past its expected finish without a notice: read its result file. Uncertain start: check the host's thread or session list before any new start.
- Full runs collect every red result; the integrator runs exact-list and snapshot tests after each intake; the integration path has priority on shared VM slots.
- QA briefs state invariants, not exact error codes; QA may retest the pre-rebase head in parallel, proven afterwards by range diff plus one full run. Handoffs list commands with exit codes; an unlisted check counts as not run.
- Rollouts: preflight under the real privilege and session context, packaged files against the install manifest, first live run early on the smallest target; handover and return contract when a rollout stops the coordinator's own host; live fixes committed back before run close.
- Decision ledger: scope, licence, security and approval questions have no deadline.

## 0.3.10 (2026-10-14)

- Security/money/data: read-only target inventory, then one Astra design review before build, then Sol builds once; Astra rechecks only for a highest-severity blocker, changed design or security boundary, or new material risk. Replaces the post-build Astra final review.
- Rollouts and installs run the real preflight read-only on the target on the first day.
- Trivial, test-only and doc-only changes stay local; other classes use test VMs for full suites, package builds and acceptance runs the local machine cannot provide. Every new or changed check runs once locally against real stored data (no production copies) before a VM or remote run; static review never accepts a check without its local run.
- No seals, checksum chains or not-run ledgers for intermediate states; a repeated failure class becomes a project recipe checkpoint. Prefer existing commands over new test tooling.
- The plan sets a bounded reserve (VM starts, rounds, self-fix kinds); inside it no STOP; an exhausted reserve joins the escalation list.
- Reports: result first, plain language, no invented abbreviations or run-together terms; prose at most five sentences, finding lists or tables within 15 lines.

## 0.3.9 (2026-10-14)

- Opus 5.5 high is the diff reviewer in a fresh session, never the coordinator, and does all rechecks and delta checks. Astra (`gpt-6-astra` high) gives security/money/data candidates one final review; it rechecks only for a highest-severity blocker, changed security boundary or new material risk. No other reviewers without a named uncovered risk or user request; Astra is the single advisor role.
- Decision ledger in `run.md`: ask once; reversible technical decisions take the recommended default after 60 minutes; payments/money movement, push, main merge, deploy/publish, deletion, account/permission/security changes, scope changes and new paid resources always wait for approval.
- Record change class, review passes, correction rounds and defects first found by QA or live runs per stream.
- Haiku routine checker is optional. New reviewers do not reset the correction-round count.
- Agent-facing text compressed (about 7,400 to 7,100 words) and QA/continuity details deduplicated into their references.

## 0.3.8 (2026-10-14)

- Count correction rounds per deliverable and user path, not per finding: one correction plus one recheck, stop after two unsuccessful rounds. Blocking only for product defects, security/data-loss risk, unmet acceptance criteria or missing sole-basis evidence; other gaps are follow-ups.
- Owners fix their own test, fixture, harness and environment failures without STOP or a separate review chain; weakened assertions are blocking. Two setup aborts before the first successful user path stop the large run.
- Classify security/money/data by effect (permissions, money calculation, user-data migration/deletion/export, deploy); test/harness/perf work without contract change is trivial or normal. One strong final review per integrated candidate; a strong reviewer may replace the ordinary one. UI is built by Opus high natively with one browser QA round, no separate review pass.
- Status by pull: notify only for STOP, decisions or acceptance-ready results; consume events once; fill free slots from the plan on each wake; plan test capacity separately; at most one advisor per decision.
- Test-suite rewrites and new harness frameworks are separate deliveries with approval and time box.
- An explicit non-coordinator `SPLIT_ORCHESTRATOR_ROLE` no longer loads coordinator rules because a run record exists.

## 0.3.7 (2026-10-10)

- Scope the Farcall no-fallback rule to Farcall dispatches. Explicitly preselected native host-stream delegation retains its assigned role and transport; it never permits rerouting a pending or unknown attempt or silently changing models.

## 0.3.6 (2026-10-10)

- Make Farcall the transport authority and Split the single workflow source; host adapters load it and project instructions add project facts.
- Centralize role/effort settings, classify trivial work by risk, and distinguish blocking findings from follow-ups without automatic extra review rounds.
- Preserve safe session continuity, add bounded incident and evidence guidance, and remove copied transport recipes in favor of the installed Farcall contract.

## 0.3.5 (2026-10-10)

- Load the coordinator rules only into coordinator sessions (run record present or `SPLIT_ORCHESTRATOR_ROLE=coordinator`), no longer on `/clear`; deduplicate the rules file.
- Add review tiers per change class (trivial, normal, security/money/data, UI) and an effort ladder: Sol medium for trivial changes, high by default, xhigh only for a named reason.
- Classify red results as product, harness or environment before a rerun; stop after two correction rounds on one finding; rerun only the red stage plus one final pass. Dependent workers exchange handoffs directly. No Opus-class models through Farcall.

## 0.3.4 (2026-10-09)

- Assign complete integrated-diff review to a separate session. Opus retains final acceptance with targeted risk, finding and test-evidence checks, deepening unresolved issues without routinely rereading the full diff or all artifacts.
- Honor explicit user/project reviewer choices, including Astra, without silently substituting models or changing implementation/QA defaults. Bind review coverage and follow-up findings to exact revisions.
- Keep handoffs within 15 lines with commit, outcome, test evidence, blockers, risks/decisions and artifact path. Full logs/traces stay with workers; summaries still grow coordinator context.

## 0.3.3 (2026-10-08)

- Prefer same-session compaction when host identity, child ownership and result delivery are preserved. Keep short checkpoints linking authoritative state; reconcile tasks, delegations and results after compaction. No fixed token thresholds or daily replacement.
- Separate coordinator replacement from context maintenance. Require completed waits/children and reconciled results, or verified host transfer; transfer dispatch authority once. Persist task/attempt IDs and dispatch intent before calls. Never redispatch for a missing notice or compact during a Farcall wait.
- Make 3–5 active streams and milestone/10–15-minute routine batches adjustable guidance. Write result files; wake immediately for blockers, decisions or acceptance-ready results, without acknowledgement-only chats or broad broadcasts.
- Record missing model/effort evidence as unknown without blocking dispatch; stop on confirmed mismatches. Document host limitations and optional versioned compaction/cache settings without changing user configuration. The coordinator does not run `/autocompact`; the starter sets effort.

## 0.3.2 (2026-10-08)

- Route browser/Electron smoke to separate Sol-medium Farcall sessions with fixed checklists and viewport/layout assertions. Implementation, integration and acceptance QA stay Sol-high; verify actual effort against the assigned role.
- Spot-check early medium smoke runs with high acceptance QA on the same cases. Return smoke to high if medium finds substantially fewer issues, recording the decision.
- Limit Haiku low to non-GUI status, log, HTTP/file link and content checks, and bounded waits. Opus high reviews diffs and evidence without browser clicks.

## 0.3.1 (2026-10-08)

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
