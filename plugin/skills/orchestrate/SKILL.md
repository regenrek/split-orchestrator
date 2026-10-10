---
name: orchestrate
description: Coordinate implementation and live QA through Farcall with Opus owning architecture and acceptance and Sol building, integrating and testing. Use for features, fixes, migrations or refactors that the user wants built or orchestrated. Requires the configured Opus session and Farcall Codex worker; do not use for read-only questions.
argument-hint: <task and optional constraints>
---

# Orchestrate

You coordinate and own final acceptance. Sol owns implementation, integration and corrections. A fresh Sol QA session tests the integrated result without repairing product code. Haiku handles bounded non-GUI checks in a small context. Before dispatch, pick the change class from the [review tiers](references/review.md); it fixes build effort, review depth and QA form for the slice.

## 1. Verify the setup

- Read the [roles, exact model/effort defaults and review tiers](references/review.md) before dispatch. This is their canonical source. Record the chosen class and any explicit user choice; no silent substitutions. The thread starter sets coordinator effort; missing settings evidence is unknown, a confirmed mismatch stops dispatch.
- Follow [one owner per rule](references/ownership.md): Farcall owns transport, Split owns workflow, host skills and project instructions add only their specific procedures and requirements. This skill uses Farcall tools directly.
- Confirm Farcall and the required local tools are available. Read [the Farcall call contract](references/farcall.md) before dispatch. Do not start replacement workers through native agents, host threads or shell CLI calls if Farcall is unavailable.
- Follow project instructions. Verify the actual entry point, start command, mandatory local checks and reproducible test data before delegation. Test fixtures must be versioned or have documented provisioning/reset steps, including external backends. Resolve only missing prerequisites; do not repeat an approval already given.
- For browser smoke, Electron testing and acceptance QA, verify browser/Electron control in the actual assigned Sol session, not only in the coordinator. A worker does not inherit your browser connection. Missing access leaves the affected checks open; agree a transparent alternative, such as restoring access in the assigned QA session, with the user. Do not silently switch tools, models or permissions.

## Keep context small

- Worker and child-agent chat reports: at most 15 lines covering exact commit, result, test evidence, blockers, risks/decisions and artifact path. Full logs/traces stay in worker artifacts; do not import them wholesale. Keep failures and unverified settings visible.
- Write long briefs/messages once with file-writing tools and pass the path (`prompt_file` for Farcall), not a long heredoc in a command. Ensure the receiver can read that path.
- Read targeted ranges and search results. Do not preload large documents or entire unrelated skills into the coordinator; still read instructions fully when required.
- Haiku checks status, logs, links and content via HTTP/files only: no browser (including headless), GUI, Electron or screenshot triage. Sol browser smoke and Electron tests run in separate Farcall sessions from implementation and acceptance QA; smoke uses a short brief and fixed checklist. Include a named viewport and no unintended element extending beyond it or horizontal overflow; document intended scroll regions. Screenshots alone do not prove layout assertions. The coordinator does not click through the browser. See the [routine checker](../../agents/routine-checker.md).

## Maintain context and continuity

Prefer compaction in the same thread/session when the host preserves identity, child ownership and result delivery. Before relying on this, check the [continuity contract](references/coordination.md): stable identity, child handles/routing, pending-call survival, cross-session resume/readdressing and shared artifact access. Unknown capabilities are unsupported. Let the host manage context size; there are no fixed token limits or daily replacement. Milestones/day boundaries are checkpoint and review opportunities. The coordinator never runs `/autocompact`, which writes user settings.

Maintain a short checkpoint linking authoritative repo/planning records. Persist task/attempt IDs and dispatch intent before worker calls, then returned session/delegation IDs and consumed events. After compaction, reload the checkpoint and reconcile task, delegation and result entries before dispatch. Do not compact during a Farcall wait; request manual compaction only after the direct wait returns. Unknown worker outcomes require recovery, never replacement work.

Coordinator replacement is separate: stop new dispatch, finish waits and session-bound children, persist/reconcile results, or use a verified host transfer. Transfer dispatch authority once; predecessor stays inactive. Same-root ancestry does not transfer handles. Re-parent only with verified authorization lineage, delivery and recovery, including late/queued notices and descendants. Missing notices never justify redispatch. If unsafe, continue in the supported session or checkpoint and report the limitation.

Repeated compaction or growing checkpoint reconciliation is a reason to stop adding streams and inspect the workload, not an automatic restart trigger. Recommend 3–5 active streams and milestone/10–15-minute routine batches, adjusted to workload; queue additional streams while independent workers stay parallel. Workers that depend on each other (implementer, integrator, QA) exchange handoffs directly through result files or their own threads; the coordinator receives decisions and acceptance-ready results. Wake immediately for blockers, decisions or acceptance-ready results. No acknowledgement-only chats or broadcasts to unaffected threads.

## 2. Define the work and owners

- Read only enough to establish scope, observable acceptance criteria and shared contracts. Leave detailed exploration to the worker that will implement and correct that deliverable.
- Agree the quality bar once per delivery: durable product work or a bounded operational task. Neither relaxes correctness, safety or approval requirements.
- Specify success, failure, retry and conflict behavior where relevant. Include observable stored outcomes, not just response messages.
- For stateful features, turn the applicable cases in [acceptance evidence](references/acceptance.md) into explicit criteria. Mark high-risk cases for explicit Sol QA checks before dispatch; add checks later if new risks emerge.
- Use the fewest workers needed. Start with one implementer unless independent deliverables justify more. Do not split investigation, coding and fixes into separate owners.
- Choose one run ID. Use it in every checkout, branch, temp directory, container, volume, database and port name the run creates. Record each resource and process as it is created in a plain Markdown list at `artifacts/<run-id>/run.md` in the coordinator's checkout. Cleanup touches only listed items.
- Assign each implementation/integration/smoke/QA worker an isolated checkout at an agreed base revision, with an explicit branch and file/component ownership. Keep the user's checkout and unsaved work intact. For multi-repository tasks, isolate every writable repository and any mutable runtime state, ports or databases used concurrently.
- Assign each shared interface/component to exactly one owner. Other workers request changes from that owner; no competing local types, adapters or second implementations. Settle ownership in every handoff.
- Name one Sol worker as the exclusive integrator and designate its integration branch/checkout. Other workers deliver commits to it. The integrator owns merges and conflict resolution; a separate reviewer covers the resulting full diff, while you assess targeted evidence for acceptance. With one implementer, that implementer also integrates.
- Use a fresh Sol-high QA session for UI/Electron work and substantial multi-worker features, or when explicitly requested. Haiku may check status, HTTP/file links and content; entry-point behavior requiring acceptance QA goes to Sol. QA owns test execution and evidence, not product repairs. Use the review/QA depth of the [selected tier](references/review.md), preserving explicit user/project reviewer choices.
- Share the short plan and honor any requested plan-approval gate before implementation or dispatch. Preparation must not become unauthorized product changes.

## 3. Prove the path, then dispatch independent work

Have the relevant owner deliver the shared interfaces early and integrate the smallest real path through the entry point, backend, persistence and reload as applicable. The owner checks it locally, then the integrator supplies the early integrated revision. The assigned QA session exercises that revision before dependent work expands; Haiku may supply HTTP/file routine evidence, but never substitutes for browser/Electron tests or acceptance QA. If it fails, return it to the owner first; independent work can continue.

Each brief stands alone. Include the user's task and constraints, plus only the context needed for that worker's assigned slice. These ownership and acceptance requirements are part of the requested orchestration, not extra restrictions invented by the transport.

```text
Task / attempt ID / task record: <durable IDs and authoritative file path>
Task and constraints: <user request and this worker's deliverable>
Checkout / branch / base: <assigned paths and exact revision>
Run ID / resource list: <run ID; coordinator's artifacts/<run-id>/run.md>
Ownership: <editable files/components; shared owners; integration owner>
Contracts: <agreed interfaces and required upstream commits>
Acceptance: <observable success, relevant failure/retry/conflict behavior>
Checks: <mandatory local checks and actual entry point>
Temp data: only inside your checkout or $TMPDIR, named with the run ID. No copies of the repository, databases, dependencies or build output. Stop processes you started. Remove disposable data you created; report leftovers (path, size, reason).
Result file: <assigned artifact path; include task/attempt IDs and result event ID>
Handoff: at most 15 chat lines; exact changes/commit, evidence link, blockers,
decisions and unverified criteria. Details in the assigned artifacts file.
Do not edit another owner's components, delegate further, or push, merge to
main, deploy or publish. Request shared changes from the coordinator.
```

Use direct Farcall completion waits and batch independent tasks in disjoint checkouts. Do not dispatch consumers of unfinished contracts. Do not poll worker status, tail logs repeatedly or do the same work while waiting. A timeout or interrupted batch has an unknown outcome until reconciled, not permission to launch duplicates.

## 4. Integrate and correct

- Inspect each handoff, including changed paths against ownership, exact session/delegation IDs, actual model/effort evidence, check exit codes and unresolved findings. A completed Farcall call is not task acceptance.
- Resume the exclusive integrator after its dependencies return. Before each intake, it compares the actual changed paths with the ownership assignment. Out-of-scope changes stop that intake and go to you and the assigned owner. You decide semantic conflicts; the integrator must not settle product behavior through an incidental merge. It integrates the agreed commits and runs mandatory checks against the combined result.
- Workers keep useful regression tests with the implementation, not only in temporary worker artifacts. No extra suites or CI machinery by default.
- Return corrections to the original worker session with the findings and expected behavior; if it cannot be resumed, report that before assigning a replacement. Classify every red result first: product (back to the implementer), harness (test owner fixes the test, no product rerun) or environment (fix or move the environment, nothing else changes). After two correction rounds on the same finding stop: narrow the task, revise the decision or escalate with both attempts summarized. Never an unannounced model switch.
- Serialize integration with corrections to the integrator's own checkout. Reintegrate corrected commits through the same integrator; do not edit worker code yourself.

For a live incident with the owner present, an already-authorized narrow correction may stay with the same assigned implementer instead of rebuilding an entire review chain at each stop. Record the changed files/revision and checks, return the change to the repository, and apply the risk-based review tier. This grants no deployment, access or publication approval and does not bypass acceptance.

## 5. Accept the integrated result

- For tiers requiring review, obtain the separate reviewer's complete integrated-diff review under the [review contract](references/review.md), tied to exact base/head commits with coverage and open findings. You own final acceptance: inspect relevant/risky/contradictory hunks and actual test evidence selectively; deepen for unresolved findings or evidence gaps. Do not blindly accept a summary or routinely import the whole diff/all artifacts again. Label the separate diff review and your **coordinator acceptance** accurately. Summaries still grow parent context.
- When the tier requires QA, give QA the integrated commit in its own checkout with isolated ports, test data and mutable runtime state. Bind the running application to that checkout/revision. QA runs applicable critical scenarios and core journeys against the real application/backend, including browser/Electron interaction for those surfaces. For other tasks, exercise the actual CLI, API or library entry point and inspect real outputs and state.
- Read [acceptance evidence](references/acceptance.md) for the scenario and evidence contract. Every result identifies the commit, running instance or command, steps, expected/actual behavior and persisted outcomes where applicable. Missing evidence leaves the criterion open. Screenshots, mocks and success messages alone do not establish acceptance.
- Assigned QA does not edit product code. Return defects to the original implementation sessions and reintegrate through the designated integrator. Before resuming the same QA session, prepare its checkout at the new integrated commit, preserve evidence and unresolved drafts, and restart/rebind its runtime. Do not force away local changes. QA verifies the checked-out hash and runtime revision before rechecking. QA-authored regression tests must be assigned file ownership and go through the integrator before final checks; avoid concurrent edits to implementer-owned tests.
- Do not click through the browser yourself. Assign evidence gaps, contradictions and marked risks to Sol QA for targeted live rechecks; review the resulting evidence yourself. Routine or smoke checks do not replace Sol acceptance QA.
- A failed assertion must produce a failed verification result. Missing tools, inaccessible environments and unrun checks remain open; never convert them into a pass.
- Keep mandatory local checks. After corrections, rerun only the red stage on the new commit, then one final QA pass over affected paths and core journeys on the final integrated commit; broaden for changes to shared components or new failures. Final evidence must match the reported final state; an earlier pass does not carry across unverified code changes.

## 6. Report the exact final state

Close the run before reporting:

- Stop processes the run started. Remove listed checkouts, temp directories, containers, volumes and test databases, except items needed for an open criterion or resumable correction. Keep evidence in the coordinator's `artifacts/<run-id>/`.
- Before removing a worker checkout, copy its Farcall records for resumable sessions from `artifacts/farcall/` into the coordinator's `artifacts/<run-id>/`, retaining delegation IDs.
- Never remove unlisted paths, anything a running process uses, or a checkout or Farcall records while `artifacts/farcall/.active` exists. Never prune shared caches or run host-wide cleanup.
- An aborted or timed-out run keeps its checkouts and reports them as open. Unknown worker outcomes block cleanup.
- Report cleanup separately from acceptance: removed items and leftovers (path, size, reason), including anything retained for an open criterion or resumable correction.

Keep the chat report within 15 lines and link the detailed evidence. Report the integrated branch/commit, requested and verified models/efforts, what changed, check evidence, separate-review findings, coordinator acceptance and unresolved criteria. Distinguish worker-complete, integrated and accepted states. Unverified or failing criteria remain open. No push, main merge, deployment or publishing without approval.

For workflow improvement, optionally record correction rounds, useful versus redundant reviews, harness/environment failures, queue wait and coordinator messages in the closing artifact. Use observations to adjust effort or concurrency; collecting metrics is not a completion gate.

An exhausted time, cost or correction budget ends the run with documented open items. It does not replace acceptance. “Done” applies only to the integrated state that was actually verified.
