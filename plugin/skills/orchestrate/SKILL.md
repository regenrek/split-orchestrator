---
name: orchestrate
description: Coordinate implementation and live QA through Farcall with Opus owning architecture and acceptance and Sol building, integrating and testing. Use for features, fixes, migrations or refactors that the user wants built or orchestrated. The root coordinator requires the configured Opus session and Farcall Codex worker; do not use for read-only questions.
argument-hint: <task and optional constraints>
---

# Orchestrate

Entrypoint for the root coordinator. A host stream reading it applies the rules for its assigned role under [transport scope](references/ownership.md#transport-scope); reading this skill does not reassign the stream as root coordinator.

You coordinate and own final acceptance. Sol owns implementation, integration and corrections; UI-class builds go to the UI implementer per review tiers. Opus diff reviewer reviews code; Astra reviews the design of security / money / data work once before build. Fresh Sol QA tests the integrated result without repairing product code. Optional Haiku routine checker handles bounded non-GUI checks. Before dispatch pick the change class from the [review tiers](references/review.md); it fixes build effort, review depth and QA form for the slice.

## 1. Verify the setup

- Read the [roles, exact model/effort defaults and review tiers](references/review.md) before dispatch; canonical source. Record chosen class and any explicit user choice; no silent substitutions. Thread starter sets coordinator effort; missing settings evidence is unknown, confirmed mismatch stops dispatch.
- Follow [one owner per rule](references/ownership.md): Farcall owns transport, Split owns workflow, host skills and project instructions add only their specific procedures and requirements. This skill uses Farcall tools directly.
- Identify this role and assigned transport under [transport scope](references/ownership.md#transport-scope). For coordinator dispatches assigned to Farcall, confirm availability and read [its contract](references/farcall.md); missing Farcall never permits native/CLI replacement. Host stream with explicitly preselected native path uses its host contract. No rerouting of pending or unknown attempts.
- Follow project instructions. Before delegation verify actual entry point, start command, mandatory local checks and reproducible test data. Test fixtures must be versioned or have documented provisioning/reset steps, including external backends. Resolve only missing prerequisites; do not repeat an approval already given.
- Rollouts, deploys and installs on a real target: on the first day run the real preflight read-only on that target (installed versions, permissions, paths, tools); put blockers it shows into the plan before design or build.
- For browser smoke, Electron testing and acceptance QA, verify browser/Electron control in the actual assigned Sol session, not only in the coordinator; workers do not inherit your browser connection. Missing access leaves affected checks open; agree a transparent alternative with the user, such as restoring access in the assigned QA session. Never silently switch tools, models or permissions.

## Keep context small

- Worker and child chat reports: result first, plain language, no invented abbreviations or run-together terms; prose at most five sentences, finding lists or tables within 15 lines; exact commit, result, test evidence, blockers, risks/decisions, artifact path. Full logs/traces stay in worker artifacts; do not import wholesale. Keep failures and unverified settings visible.
- Write long briefs/messages once with file-writing tools and pass the path (`prompt_file` for Farcall), not a long heredoc in a command. Ensure the receiver can read that path.
- Read targeted ranges and search results. Do not preload large documents or entire unrelated skills into the coordinator; still read instructions fully when required.
- Haiku ([routine checker](../../agents/routine-checker.md)) checks status, logs, links and content via HTTP/files only: no browser (including headless), GUI, Electron or screenshot triage. Sol browser smoke and Electron tests run in Farcall sessions separate from implementation and acceptance QA, under the [smoke contract](references/acceptance.md#browser-and-electron-smoke). Coordinator does not click through the browser.

## Maintain context and continuity

Read the [continuity contract](references/coordination.md) before relying on compaction or replacing the coordinator; it owns checkpoint, compaction, reconciliation and replacement rules. Core: prefer same-session compaction where the host preserves identity, child ownership and result delivery; unknown capabilities are unsupported; no fixed token limits or daily replacement. Keep a short checkpoint linking authoritative repo/planning records; persist task/attempt IDs and dispatch intent before worker calls. Never compact during a Farcall wait. Unknown worker outcomes require recovery, never replacement work; missing notices never justify redispatch. Coordinator never runs `/autocompact` (writes user settings).

Repeated compaction or growing checkpoint reconciliation: stop adding streams and inspect workload; not an automatic restart trigger. Recommend 3–5 active streams, adjusted to workload; queue more while independent workers stay parallel. Dependent workers (implementer, integrator, QA) exchange handoffs directly through result files or their own threads. Status by pull: workers update result files; they message the coordinator only for STOP, decision or acceptance-ready result. On each wake reconcile arrived decisions and results, then fill free stream slots with ready independent work from the plan. No acknowledgement-only chats or broadcasts to unaffected threads.

Decisions put to the user: one decision ledger in `run.md` (ID, question, asked-at, recommended default, deadline: asked-at plus 60 minutes for reversible technical decisions, otherwise none). Ask once; record answers and approvals on arrival; do not repeat the full list in every message. A reversible technical decision unanswered after 60 minutes proceeds with the recommended default; record it. Never by default: payments or money movement, push, merge to main, deploy or publish, deletion, account, permission or security changes, scope change, new paid resources; these wait for explicit approval.

## 2. Define the work and owners

- Read only enough to establish scope, observable acceptance criteria and shared contracts. Detailed exploration belongs to the worker implementing and correcting that deliverable.
- Agree the quality bar once per delivery: durable product work or bounded operational task. Neither relaxes correctness, safety or approval requirements.
- Specify success, failure, retry and conflict behavior where relevant, including observable stored outcomes, not just response messages.
- For stateful features turn applicable cases in [acceptance evidence](references/acceptance.md) into explicit criteria. Mark high-risk cases for explicit Sol QA checks before dispatch; add checks if new risks emerge.
- Fewest workers needed. Start with one implementer unless independent deliverables justify more. Do not split investigation, coding and fixes into separate owners.
- Security / money / data: read-only inventory of the real target and data first, then one design review per [review tiers](references/review.md), then the assigned builder builds once against the reviewed design.
- Plan sets a bounded reserve before start: test-VM/remote starts, correction rounds (never above the two-round limit), allowed owner self-fix kinds (default: test, fixture, harness, environment). Work inside the reserve needs no STOP. An exhausted reserve is on the escalation list; then apply the round and budget rules below.
- Test-suite rewrites, new harness/verifier/fixture frameworks and schema/migration cleanups are separate deliveries with user approval and a time box, never side work of a feature slice. Prefer an existing command over new test tooling. Disposable artifacts (spikes, test figures) get no final-asset acceptance criteria.
- Choose one run ID. Use it in every checkout, branch, temp directory, container, volume, database and port name the run creates. Record each resource and process when created in a plain Markdown list at `artifacts/<run-id>/run.md` in the coordinator's checkout. Cleanup touches only listed items.
- Each implementation/integration/smoke/QA worker gets an isolated checkout at an agreed base revision, explicit branch and file/component ownership. Keep the user's checkout and unsaved work intact. Multi-repository tasks: isolate every writable repository and any concurrently used mutable runtime state, ports or databases.
- Each shared interface/component has exactly one owner. Others request changes from that owner; no competing local types, adapters or second implementations. Settle ownership in every handoff.
- Name one Sol worker exclusive integrator with its integration branch/checkout; other workers deliver commits to it. Integrator owns merges and conflict resolution; where the tier requires review, a separate reviewer covers the resulting full diff; you assess targeted evidence for acceptance. With one implementer, that implementer also integrates, including a sole UI implementer; UI work alongside other workers delivers commits to the Sol integrator.
- Fresh Sol-high QA session for UI/Electron work and substantial multi-worker features, or when explicitly requested. Haiku may check status, HTTP/file links and content; entry-point behavior requiring acceptance QA goes to Sol. QA owns test execution and evidence, not product repairs. Use the review/QA depth of the [selected tier](references/review.md), preserving explicit user/project reviewer choices.
- Share the short plan and honor any requested plan-approval gate before implementation or dispatch. Preparation must not become unauthorized product changes.

## 3. Prove the path, then dispatch independent work

Relevant owner delivers shared interfaces early and integrates the smallest real path through entry point, backend, persistence and reload as applicable, checks it locally, then the integrator supplies the early integrated revision. Assigned QA exercises that revision before dependent work expands; Haiku may supply HTTP/file routine evidence, never a substitute for browser/Electron tests or acceptance QA. On failure return it to the owner first; independent work can continue.

Each brief stands alone: user's task and constraints plus only the context that worker's slice needs. These ownership and acceptance requirements are part of the requested orchestration, not extra restrictions invented by the transport.

```text
Task / attempt ID / task record: <durable IDs and authoritative file path>
Task and constraints: <user request and this worker's deliverable>
Checkout / branch / base: <assigned paths and exact revision>
Run ID / resource list: <run ID; coordinator's artifacts/<run-id>/run.md>
Ownership: <editable files/components; shared owners; integration owner>
Contracts: <agreed interfaces and required upstream commits>
Acceptance: <observable success, relevant failure/retry/conflict behavior>
Checks: <mandatory local checks and actual entry point>; run new or changed
checks locally first; existing commands over new tooling; no seals or checksum
chains for intermediate states
Temp data: only inside your checkout or $TMPDIR, named with the run ID. No copies of the repository, databases, dependencies or build output. Stop processes you started. Remove disposable data you created; report leftovers (path, size, reason).
Result file: <assigned artifact path; include task/attempt IDs and result event ID>
Handoff: result first, plain language, no invented abbreviations or run-together
terms; prose at most 5 sentences, finding lists or tables within 15 lines;
exact changes/commit, evidence link, blockers,
decisions and unverified criteria. Details in the assigned artifacts file.
Do not edit another owner's components, delegate further, or push, merge to
main, deploy or publish. Request shared changes from the coordinator.
```

Farcall dispatches: direct completion waits; batch independent tasks in disjoint checkouts. Explicitly selected native host streams use the corresponding host completion contract under [transport scope](references/ownership.md#transport-scope). Do not dispatch consumers of unfinished contracts. While waiting, do not poll worker status, repeatedly tail logs or do the same work. Timeout or interrupted batch: outcome unknown until reconciled, never permission to launch duplicates.

## 4. Integrate and correct

- Inspect each handoff: changed paths against ownership, exact session/delegation IDs, actual model/effort evidence, check exit codes, unresolved findings. A completed Farcall call is not task acceptance.
- Resume the exclusive integrator after its dependencies return. Before each intake it compares actual changed paths with the ownership assignment; out-of-scope changes stop that intake and go to you and the assigned owner. You decide semantic conflicts; integrator must not settle product behavior through an incidental merge. It integrates agreed commits and runs mandatory checks on the combined result.
- Workers keep useful regression tests with the implementation, not only in temporary worker artifacts. No extra suites or CI machinery by default.
- Return corrections to the original worker session with findings and expected behavior; if it cannot resume, report that before assigning a replacement. Classify every red result first: product (back to implementer), harness (test owner fixes test, no product rerun) or environment (fix or move environment, nothing else changes). Never an unannounced model switch.
- Count correction rounds per deliverable and user path, not per finding; new finding IDs, threads, reviewers or run IDs do not reset the count. Default: one batched correction plus one targeted recheck. After two unsuccessful rounds stop: narrow the task, change approach or owner, or leave named criteria open; summarize both attempts. Limits stop spending; they never turn a blocker into a pass.
- Owners fix their own test, fixture, harness and environment failures inside their assignment and recheck: no STOP, no coordinator approval, no separate review chain. Never weaken assertions or product safety; a weakened assertion is a blocking finding. Report changed assertions in the handoff; diff reviewer checks them, or coordinator acceptance in tiers without diff review. QA may fix its own probes, never product code. Escalate only for product contract, schema, permission, security or scope change; exhausted plan reserve; new paid resources or accounts; two unsuccessful rounds; decisions only the user can make.
- Serialize integration with corrections to the integrator's own checkout. Reintegrate corrected commits through the same integrator; never edit worker code yourself.

Live incident with owner present: an already-authorized narrow correction may stay with the same assigned implementer instead of rebuilding the review chain at each stop. Record changed files/revision and checks, return the change to the repository, apply the risk-based review tier. Grants no deployment, access or publication approval; does not bypass acceptance.

## 5. Accept the integrated result

- Tiers requiring review: obtain the separate reviewer's complete integrated-diff review under the [review contract](references/review.md), tied to exact base/head commits with coverage and open findings. You own final acceptance: selectively inspect relevant/risky/contradictory hunks and actual test evidence; deepen for unresolved findings or evidence gaps. Never blindly accept a summary or routinely re-import the whole diff/all artifacts. Label separate diff review and your **coordinator acceptance** accurately. Summaries still grow parent context.
- Tiers requiring QA: give QA the integrated commit in its own checkout with isolated ports, test data and mutable runtime state; bind the running application to that checkout/revision. QA runs applicable critical scenarios and core journeys against the real application/backend, including browser/Electron interaction for those surfaces. Other tasks: exercise the actual CLI, API or library entry point and inspect real outputs and state.
- Read [acceptance evidence](references/acceptance.md) for the scenario and evidence contract. Every result identifies commit, running instance or command, steps, expected/actual behavior and persisted outcomes where applicable. Missing evidence leaves the criterion open. Screenshots, mocks and success messages alone do not establish acceptance.
- Assigned QA does not edit product code. Return defects to original implementation sessions; reintegrate through the designated integrator. QA rechecks, checkout rebinding and QA-authored tests follow [acceptance evidence](references/acceptance.md); do not force away local changes; avoid concurrent edits to implementer-owned tests.
- Never click through the browser yourself. Assign evidence gaps, contradictions and marked risks to Sol QA for targeted live rechecks; review the resulting evidence yourself. Routine or smoke checks do not replace Sol acceptance QA.
- A failed assertion must produce a failed verification result. Missing tools, inaccessible environments and unrun checks stay open; never convert them into a pass.
- Keep mandatory local checks. After corrections rerun only the red stage on the new commit, then one final QA pass over affected paths and core journeys on the final integrated commit; broaden for shared-component changes or new failures. Final evidence must match the reported final state; an earlier pass does not carry across unverified code changes.

## 6. Report the exact final state

Close the run before reporting:

- Stop processes the run started. Remove listed checkouts, temp directories, containers, volumes and test databases, except items needed for an open criterion or resumable correction. Keep evidence in the coordinator's `artifacts/<run-id>/`.
- Before removing a worker checkout, copy its Farcall records for resumable sessions from `artifacts/farcall/` into the coordinator's `artifacts/<run-id>/`, retaining delegation IDs.
- Never remove unlisted paths, anything a running process uses, or a checkout or Farcall records while `artifacts/farcall/.active` exists. Never prune shared caches or run host-wide cleanup.
- Aborted or timed-out run keeps its checkouts and reports them open. Unknown worker outcomes block cleanup.
- Report cleanup separately from acceptance: removed items and leftovers (path, size, reason), including anything retained for an open criterion or resumable correction.

Chat report per the report rule in [Keep context small](#keep-context-small); link detailed evidence: integrated branch/commit, requested and verified models/efforts, what changed, check evidence, separate-review findings, coordinator acceptance, unresolved criteria. Distinguish worker-complete, integrated and accepted states. Unverified or failing criteria stay open. No push, main merge, deployment or publishing without approval.

Record per stream in `run.md`: change class, review passes, correction rounds, and defects first found by QA or a live run rather than review. Optionally add harness/environment failures, queue wait and coordinator messages. Use them to adjust effort, review depth or concurrency; not a completion gate.

Exhausted time, cost or correction budget ends the run with documented open items; it never replaces acceptance. “Done” applies only to the integrated state actually verified.
