# Integrated review and coordinator acceptance

Canonical role, model and effort reference. Pick change class before dispatch; write it into the brief. Review and QA follow the tier. Explicit user/project reviewer choice replaces only the reviewer choice, not acceptance criteria or safety boundaries.

## Roles and settings

| Role | Default model / effort | Transport and responsibility |
|---|---|---|
| Root coordinator | `claude-opus-5-5` / high | Host session; scope, contracts, owners, targeted evidence inspection, final acceptance |
| Implementer / integrator | `gpt-6.1-sol` / by tier below | Farcall; build, local checks, corrections; one exclusive integrator |
| UI implementer | `claude-opus-5-5` / high | Native session; UI class only; builds and corrects UI from the design brief |
| Diff reviewer | `claude-opus-5-5` / high, or explicit user/project choice | Fresh native session, never the coordinator; full integrated diff and relevant surrounding code; all rechecks and delta checks |
| Design reviewer | `gpt-6-astra` / high | Fresh Farcall session, or explicitly chosen host session; security / money / data class only; once per delivery, not per slice, on the design before build, after the read-only target inventory |
| Advisor | `gpt-6-astra` / high | Irreversible or out-of-domain decisions, copy, legal |
| Acceptance QA | `gpt-6.1-sol` / high | Fresh Farcall session; real entry paths and persisted outcomes, no product repairs |
| Browser / Electron smoke | `gpt-6.1-sol` / medium | Separate short Farcall session, fixed checklist, verified tool access; never a substitute for acceptance QA |
| Routine checker (optional) | `claude-haiku-5-5` / low | Native small-context session; log reads, status, HTTP/files, bounded waits; no browser, GUI or screenshot triage |

Transport entries are coordinator defaults; [explicitly chosen native host streams](ownership.md#transport-scope) keep their assigned role and worker settings. Starter sets coordinator effort. Record exact model, effort and transport before dispatch. Missing execution evidence is `unknown`; only a confirmed mismatch stops dispatch for settings. Requests and self-description alone do not prove execution. Unknown worker outcomes require the assigned transport's recovery contract. Never silently change models, effort, permissions or transport.

Opus-class review roles run natively by default as a workflow choice, not a Farcall limitation or API-pricing claim. Explicit user-approved alternatives still require actual tool access. No reviewers or planners beyond this table without a named, still-uncovered risk or user request. Start with at most two native strong-model children; adjustable capacity guidance, not an acceptance gate. Per decision ask at most one advisor, only for irreversible or out-of-domain questions, copy or legal. Decide reversible technical questions yourself and record them; the decision ledger covers only questions you put to the user.

## Change classes

| Class | Examples | Build | Review | QA |
|---|---|---|---|---|
| trivial | bounded copy or test-only edit, no shared contract or material behavior change | Sol medium | local checks only | implementer's checks; coordinator records acceptance |
| normal | feature slice, fix touching shared types | Sol high | diff reviewer, full diff | Sol QA on the real entry path when behaviour changed |
| security / money / data | auth/permission boundaries, payments and money calculation, user-data migrations, deletion or export of user data, deploy/publish | Sol high | design reviewer once before build; diff reviewer per slice; design reviewer sees the final integrated candidate only if design or security boundary changed during build | fresh Sol QA with persisted-state checks |
| UI | visible layout or interaction change | UI implementer (Opus high) from a design brief, no Sol builder | no separate review pass | one browser QA round plus one fix, named viewport, screenshots |

Classify by effect, not file count or extension; record the class in `run.md`. Security, money, data integrity, deployments and runtime configuration are not trivial. Test, fixture, harness or performance work changing no contract, stored data or security boundary is trivial or normal, also in money/data code. Overlapping classes: include applicable risk checks without duplicating equivalent passes; UI touching auth, money or stored data adds that class's review. Explicit reviewer choice replacing the diff reviewer also does its delta checks. Trivial, test-only and doc-only changes: local checks only, no test VM or remote test machine. Other classes use test VMs for full suites, package builds and acceptance runs the local machine cannot provide. Project defaults must not add a universal review chain; justify extra depth per change. User-required checks remain binding.

Use high for normal work. Escalate to xhigh only after a high-effort attempt exposes a named gap; record why. Trivial implementation at medium and fixed-checklist smoke at medium are distinct cases. Acceptance QA stays high.

## Review and findings

Design review input: plan, acceptance criteria, affected contracts and read-only inventory results (run by the implementer or QA session with target access). Design findings go to the coordinator, who updates the plan before dispatch.

Give the diff reviewer requirements, acceptance criteria, exact base and integrated head commits, changed-file inventory and evidence paths. Review must cover full diff and relevant surrounding code for correctness, ownership, interface compatibility and regressions, and disclose any unreviewed portion, unavailable evidence or truncated input. Never treat an incomplete review as complete. New or changed checks, harness or verifier code: review needs its local run result; static review alone never accepts a check. Reviewer does not fix product code; findings return to original owners through the integrator.

Report result first, plain language, no invented abbreviations or run-together terms; prose at most five sentences, finding lists or tables within 15 lines: exact reviewed base/head, coverage and verdict, blocking findings, test evidence (including unrun checks), unresolved risks/decisions, detailed artifact path. Full logs/traces stay in worker artifacts under existing retention rules. If findings exceed the budget, report counts/severity and index them in the artifact; never omit a blocker to meet the line limit.

Coordinator owns final acceptance. Inspect findings/index and targeted test evidence, then relevant, risky or contradictory diff hunks and surrounding code. Deepen and request focused clarification or rechecks for open findings, inconsistent evidence, missing coverage or new risks. Green reviewer summary alone is insufficient. Do not routinely re-import the complete diff or read every artifact in full; load only portions needed for decisions, expand when evidence warrants.

Mark each finding **blocking** or **follow-up**, with the concrete risk. Blocking only: proven product defect, security or data-loss risk, unmet acceptance criterion, weakened assertion or product-safety check, or missing evidence that is the sole basis for an acceptance claim. Other gaps in evidence format, test quality, harness robustness, docs or style: follow-up. After the one recheck, new findings are follow-ups unless blocking by this definition. Coordinator may reclassify with a recorded reason; an unmet acceptance criterion cannot disappear through relabeling. Blocking findings go to the original owner. Follow-ups stay visible in the final report and never automatically start another correction or review round.

Bind review and QA evidence to the final integrated revision. A follow-up implemented during the run joins the final delta and needs appropriate verification. Where the tier requires review, the diff reviewer checks the changed delta and affected interactions, broadens when warranted, and records carried-forward coverage plus new head. Changed or unexplained base invalidates carry-forward. Diff reviewer and affected checks verify fixes; design reviewer rechecks only for a highest-severity blocker, changed design or security boundary, or new material risk. Keep unresolved criteria open. Label separate review and coordinator acceptance accurately; neither replaces live QA.
