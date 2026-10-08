---
name: orchestrate
description: Coordinate implementation and live QA through Farcall with Opus owning architecture and acceptance and Sol building, integrating and testing. Use for features, fixes, migrations or refactors that the user wants built or orchestrated. Requires the configured Opus session and Farcall Codex worker; do not use for read-only questions.
argument-hint: <task and optional constraints>
---

# Orchestrate

You coordinate and own final acceptance. Sol owns implementation, integration and corrections. A fresh Sol QA session tests the integrated result without repairing product code. Haiku handles bounded non-GUI checks in a small context. Sol owns browser smoke, Electron tests and acceptance QA, each in its own Farcall session.

## 1. Verify the setup

- Coordinator/reviewer: `claude-opus-5-5`, effort `high`. The thread starter sets effort; report deviations and stop dispatch rather than silently continuing.
- Non-GUI routine checks: native `split-orchestrator:routine-checker` subagent, exact `claude-haiku-5-5`, effort `low`. Its brief defines checkpoints and evidence; it is not a Farcall implementer or acceptance QA. Verify actual model from the matching Claude transcript and effort from execution settings; requested values or self-description alone do not prove execution. Missing verification stays open; never substitute an alias.
- Sol workers: exact `gpt-6.1-sol` through Farcall's `codex_worker.run` or `codex_worker.run_batch`. Implementation, integration and acceptance QA require `high`; `medium` is allowed only for browser/Electron smoke sessions with a fixed checklist. Record the role and verify actual effort against it; medium must never qualify as acceptance QA.
- No Astra, Sonnet workers, aliases or silent model/effort substitutions. Read the parent session settings and verify worker settings from execution metadata, not a model's self-description. If settings conflict or cannot be verified, report the blocker; do not claim a verified run. A requested setting alone is not evidence of the executed setting.
- Confirm Farcall and the required local tools are available. Read [the Farcall call contract](references/farcall.md) before dispatch. Do not start replacement workers through native agents, host threads or shell CLI calls if Farcall is unavailable.
- Follow project instructions. Verify the actual entry point, start command, mandatory local checks and reproducible test data before delegation. Test fixtures must be versioned or have documented provisioning/reset steps, including external backends. Resolve only missing prerequisites; do not repeat an approval already given.
- For browser smoke, Electron testing and acceptance QA, verify browser/Electron control in the actual assigned Sol session, not only in the coordinator. A worker does not inherit your browser connection. Missing access leaves the affected checks open; agree a transparent alternative, such as restoring access in the assigned QA session, with the user. Do not silently switch tools, models or permissions.

## Keep context small

- Worker and child-agent chat reports: at most 15 lines covering findings, evidence, blockers and decisions; link the detailed artifact. Keep failures and unverified settings visible.
- Write long briefs/messages once with file-writing tools and pass the path (`prompt_file` for Farcall), not a long heredoc in a command. Ensure the receiver can read that path.
- Delegate status collection, filtered log inspection and routine waits to the small-context routine checker. Give it a standalone brief, not a full-history fork; receive only its summary. Use a blocking wait or one bounded script with a deadline and interval, never many short coordinator steps. Farcall completion waits remain direct; neither agent polls pending workers.
- Read targeted ranges and search results. Do not preload large documents or entire unrelated skills into the coordinator; still read instructions fully when required.
- Haiku checks status, logs, links and content via HTTP/files only: no browser (including headless), GUI, Electron or screenshot triage. Give Sol browser smoke and Electron tests in separate Farcall sessions from implementation and acceptance QA. A quick smoke uses a short brief and fixed checklist at Sol/medium. Spot-check the first medium runs with high acceptance QA on the same cases and revision. If medium finds substantially fewer issues, return smoke to high and record the decision; see [acceptance evidence](references/acceptance.md). Include a named viewport and no unintended element extending beyond it or horizontal overflow; document intended scroll regions. Screenshots alone do not prove layout assertions. The coordinator does not click through the browser. See the [routine checker](../../agents/routine-checker.md).

## 2. Define the work and owners

- Read only enough to establish scope, observable acceptance criteria and shared contracts. Leave detailed exploration to the worker that will implement and correct that deliverable.
- Specify success, failure, retry and conflict behavior where relevant. Include observable stored outcomes, not just response messages.
- For stateful features, turn the applicable cases in [acceptance evidence](references/acceptance.md) into explicit criteria. Mark high-risk cases for explicit Sol QA checks before dispatch; add checks later if new risks emerge.
- Use the fewest workers needed. Start with one implementer unless independent deliverables justify more. Do not split investigation, coding and fixes into separate owners.
- Choose one run ID. Use it in every checkout, branch, temp directory, container, volume, database and port name the run creates. Record each resource and process as it is created in a plain Markdown list at `artifacts/<run-id>/run.md` in the coordinator's checkout. Cleanup touches only listed items.
- Assign each implementation/integration/smoke/QA worker an isolated checkout at an agreed base revision, with an explicit branch and file/component ownership. Keep the user's checkout and unsaved work intact. For multi-repository tasks, isolate every writable repository and any mutable runtime state, ports or databases used concurrently.
- Assign each shared interface/component to exactly one owner. Other workers request changes from that owner; no competing local types, adapters or second implementations. Settle ownership in every handoff.
- Name one Sol worker as the exclusive integrator and designate its integration branch/checkout. Other workers deliver commits to it. The integrator owns merges and conflict resolution; you review the resulting diff. With one implementer, that implementer also integrates.
- Use a fresh Sol-high QA session for UI/Electron work and substantial multi-worker features, or when explicitly requested. Haiku may check status, HTTP/file links and content; entry-point behavior requiring acceptance QA goes to Sol. QA owns test execution and evidence, not product repairs. An optional fresh reviewer needs an explicitly agreed model and transport; it is not an automatic extra role or an Astra exception.
- Share the short plan and honor any requested plan-approval gate before implementation or dispatch. Preparation must not become unauthorized product changes.

## 3. Prove the path, then dispatch independent work

Have the relevant owner deliver the shared interfaces early and integrate the smallest real path through the entry point, backend, persistence and reload as applicable. The owner checks it locally, then the integrator supplies the early integrated revision. The assigned QA session exercises that revision before dependent work expands; Haiku may supply HTTP/file routine evidence, but never substitutes for browser/Electron tests or acceptance QA. If it fails, return it to the owner first; independent work can continue.

Each brief stands alone. Include the user's task and constraints, plus only the context needed for that worker's assigned slice. These ownership and acceptance requirements are part of the requested orchestration, not extra restrictions invented by the transport.

```text
Task and constraints: <user request and this worker's deliverable>
Checkout / branch / base: <assigned paths and exact revision>
Run ID / resource list: <run ID; coordinator's artifacts/<run-id>/run.md>
Ownership: <editable files/components; shared owners; integration owner>
Contracts: <agreed interfaces and required upstream commits>
Acceptance: <observable success, relevant failure/retry/conflict behavior>
Checks: <mandatory local checks and actual entry point>
Temp data: only inside your checkout or $TMPDIR, named with the run ID. No copies of the repository, databases, dependencies or build output. Stop processes you started. Remove disposable data you created; report leftovers (path, size, reason).
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
- Return corrections to the original worker session with the findings and expected behavior. If that session cannot be resumed, report the limitation before assigning a replacement. Repeated failure calls for a narrower task or a revised decision, never an unannounced model switch.
- Serialize integration with corrections to the integrator's own checkout. Reintegrate corrected commits through the same integrator; do not edit worker code yourself.

## 5. Accept the integrated result

- Read the integrated diff yourself. Check shared ownership, interfaces and actual test artifacts, not only the worker summary. You own final acceptance. Call this **coordinator review**; identify separate QA or a fresh review without relabeling your own review as independent.
- Give QA the integrated commit in its own checkout with isolated ports, test data and mutable runtime state. Bind the running application to that checkout/revision. QA runs applicable critical scenarios and core journeys against the real application/backend, including browser/Electron interaction for those surfaces. For other tasks, exercise the actual CLI, API or library entry point and inspect real outputs and state.
- Read [acceptance evidence](references/acceptance.md) for the scenario and evidence contract. Every result identifies the commit, running instance or command, steps, expected/actual behavior and persisted outcomes where applicable. Missing evidence leaves the criterion open. Screenshots, mocks and success messages alone do not establish acceptance.
- QA does not edit product code. Return defects to the original implementation sessions and reintegrate through the designated integrator. Before resuming the same QA session, prepare its checkout at the new integrated commit, preserve evidence and unresolved drafts, and restart/rebind its runtime. Do not force away local changes. QA verifies the checked-out hash and runtime revision before rechecking. QA-authored regression tests must be assigned file ownership and go through the integrator before final checks; avoid concurrent edits to implementer-owned tests.
- Do not click through the browser yourself. Assign evidence gaps, contradictions and marked risks to Sol QA for targeted live rechecks; review the resulting evidence yourself. Routine or smoke checks do not replace Sol acceptance QA.
- A failed assertion must produce a failed verification result. Missing tools, inaccessible environments and unrun checks remain open; never convert them into a pass.
- Keep mandatory local checks. After corrections, QA rechecks affected paths and core journeys on the final integrated commit; broaden for changes to shared components or new failures. Avoid duplicate full verification passes. Confirm final evidence matches the reported final state; do not carry an earlier pass across unverified code changes.

## 6. Report the exact final state

Close the run before reporting:

- Stop processes the run started. Remove listed checkouts, temp directories, containers, volumes and test databases, except items needed for an open criterion or resumable correction. Keep evidence in the coordinator's `artifacts/<run-id>/`.
- Before removing a worker checkout, copy its Farcall records for resumable sessions from `artifacts/farcall/` into the coordinator's `artifacts/<run-id>/`, retaining delegation IDs.
- Never remove unlisted paths, anything a running process uses, or a checkout or Farcall records while `artifacts/farcall/.active` exists. Never prune shared caches or run host-wide cleanup.
- An aborted or timed-out run keeps its checkouts and reports them as open. Unknown worker outcomes block cleanup.
- Report cleanup separately from acceptance: removed items and leftovers (path, size, reason), including anything retained for an open criterion or resumable correction.

Keep the chat report within 15 lines and link the detailed evidence. Report the integrated branch/commit, requested and verified models/efforts, what changed, check evidence, coordinator-review findings and unresolved criteria. Distinguish worker-complete, integrated and accepted states. Unverified or failing criteria remain open. No push, main merge, deployment or publishing without approval.

An exhausted time, cost or correction budget ends the run with documented open items. It does not replace acceptance. “Done” applies only to the integrated state that was actually verified.
