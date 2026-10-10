# Integrated review and coordinator acceptance

This is the canonical role, model and effort reference. Pick the change class before dispatch and write it into the brief. Review and QA follow the tier; an explicit user/project reviewer choice (including Astra) replaces the reviewer choice only, not acceptance criteria or safety boundaries.

## Roles and settings

| Role | Default model / effort | Transport and responsibility |
|---|---|---|
| Coordinator | `claude-opus-5-5` / high | Host session; scope, contracts, owners, targeted evidence inspection and final acceptance |
| Implementer / integrator | `gpt-6.1-sol` / by tier below | Farcall; build, local checks, corrections; one exclusive integrator |
| Diff reviewer | `gpt-6.1-sol` / high, or explicit user/project choice | Separate session; full integrated diff and relevant surrounding code |
| Acceptance QA | `gpt-6.1-sol` / high | Fresh Farcall session; real entry paths and persisted outcomes, no product repairs |
| Browser / Electron smoke | `gpt-6.1-sol` / medium | Separate short Farcall session, fixed checklist and verified tool access; never a substitute for acceptance QA |
| Routine checker | `claude-haiku-5-5` / low | Native small-context session; status, logs, HTTP/files, bounded waits; no browser, GUI or screenshot triage |

The starter sets coordinator effort. Record exact selected model, effort and transport before dispatch. Missing execution evidence is `unknown`; only a confirmed mismatch stops dispatch for settings. Requests and self-description alone do not prove execution. Unknown worker outcomes are different and require Farcall recovery. Never silently change models, effort, permissions or transport.

Opus-class review roles run natively by default as a workflow choice, not a Farcall limitation or an API-pricing claim. Explicit user-approved alternatives still require actual tool access. Additional strong reviewers/planners need the task's risk or an explicit request. Start with at most two native strong-model children as adjustable capacity guidance, not an acceptance gate.

## Change classes

| Class | Examples | Build | Review | QA |
|---|---|---|---|---|
| trivial | bounded copy or test-only edit, no shared contract or material behavior change | Sol medium | local checks only | implementer's checks; coordinator records acceptance |
| normal | feature slice, fix touching shared types | Sol high | `gpt-6.1-sol` high or chosen reviewer, full diff | Sol QA on the real entry path when behaviour changed |
| security / money / data | auth, payments, persistence, migrations, exports | Sol high | full diff review, then a strong-model final review | fresh Sol QA with persisted-state checks |
| UI | visible layout or interaction change | Sol high from a design brief | full diff review high, plus one bounded UI review pass by a strong UI model run natively (screenshots, about 50 calls) | browser QA, named viewport, screenshots |

Classify by effect, not file count or extension. Security, money, data integrity, deployments and runtime configuration are not trivial. When classes overlap, include the applicable risk checks without duplicating equivalent review passes. Project defaults must not add a universal review chain; justify extra depth for the particular change. User-required checks remain binding.

Use high for normal work. Escalate to xhigh only after a high-effort attempt exposes a named gap; record why. Trivial implementation at medium and fixed-checklist smoke at medium are distinct cases. Keep acceptance QA at high. The UI call count is a scope guide, not a reason to drop findings or stop required verification.

## Review and findings

Give the reviewer the requirements, acceptance criteria, exact base and integrated head commits, changed-file inventory and evidence paths. It must cover the full diff and relevant surrounding code for correctness, ownership, interface compatibility and regressions. It must disclose any unreviewed portion, unavailable evidence or truncated input. Do not treat an incomplete review as complete. The reviewer does not fix product code; findings return to the original owners through the integrator.

Return at most 15 chat lines: exact reviewed base/head, coverage and verdict, blocking findings, test evidence (including unrun checks), unresolved risks/decisions and detailed artifact path. Keep full logs/traces in worker artifacts, subject to the existing retention rules. If findings exceed the summary budget, report counts/severity and index them in the artifact; never omit a blocker to meet the line limit.

Opus owns final acceptance. Inspect the findings/index and targeted test evidence, then relevant, risky or contradictory diff hunks and their surrounding code. Deepen inspection and request focused clarification or rechecks for open findings, inconsistent evidence, missing coverage or newly discovered risks. A green reviewer summary alone is insufficient. Do not routinely import the complete diff again or read every artifact in full. Load only the referenced portions needed to resolve decisions; expand coverage when the evidence warrants it.

Mark each finding **blocking** or **follow-up**, with the concrete risk. The coordinator may reclassify it with a recorded reason; an unmet acceptance criterion cannot disappear through relabeling. Blocking findings go to the original owner for correction. Follow-ups remain visible in the final report and do not automatically start another correction or review round.

Bind review and QA evidence to the final integrated revision. If a follow-up is implemented during the run, it becomes part of the final delta and needs appropriate verification. Where the tier requires a diff reviewer, review the changed delta and affected interactions; broaden when warranted and record carried-forward coverage plus the new head. A changed or unexplained base invalidates carry-forward. Return to the strong final reviewer only for a highest-severity blocker, a changed security boundary or a new material risk; otherwise the ordinary reviewer and affected checks verify the fix. Keep unresolved criteria open. Label separate review and coordinator acceptance accurately; neither replaces live QA.
