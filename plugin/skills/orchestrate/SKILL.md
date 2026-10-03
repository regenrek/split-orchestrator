---
name: orchestrate
description: Coordinate implementation through Farcall with Opus reviewing and Sol implementing and integrating. Use for features, fixes, migrations or refactors that the user wants built or orchestrated. Requires the configured Opus session and Farcall Codex worker; do not use for read-only questions.
argument-hint: <task and optional constraints>
---

# Orchestrate

You coordinate and own final acceptance. Sol owns implementation, integration and corrections.

## 1. Verify the setup

- Coordinator/reviewer: `claude-opus-5-5`, effort `high`.
- Every implementation/integration worker: `gpt-6.1-sol`, effort `high`, through Farcall's `codex_worker.run` or `codex_worker.run_batch`.
- No Astra, Sonnet workers, aliases or silent model/effort substitutions. Read the parent session settings and verify worker settings from execution metadata, not a model's self-description. If settings conflict or cannot be verified, report the blocker; do not claim a verified run. A requested setting alone is not evidence of the executed setting.
- Confirm Farcall and the required local tools are available. Read [the Farcall call contract](references/farcall.md) before dispatch. Do not start replacement workers through native agents, host threads or shell CLI calls if Farcall is unavailable.
- Follow project instructions. Identify the actual application/entry point, mandatory local checks, browser and test data before unattended execution. Resolve only missing prerequisites; do not repeat an approval already given.

## 2. Define the work and owners

- Read only enough to establish scope, observable acceptance criteria and shared contracts. Leave detailed exploration to the worker that will implement and correct that deliverable.
- Specify success, failure, retry and conflict behavior where relevant. Include observable stored outcomes, not just response messages.
- Use the fewest workers needed. Start with one unless independent deliverables justify more. Do not split investigation, coding and fixes into separate owners.
- Assign each worker an isolated checkout at an agreed base revision, with an explicit branch and file/component ownership. Keep the user's checkout and unsaved work intact. For multi-repository tasks, isolate every writable repository and any mutable runtime state, ports or databases used concurrently.
- Assign each shared interface/component to exactly one owner. Other workers request changes from that owner; no competing local types, adapters or second implementations. Settle ownership in every handoff.
- Name one Sol worker as the exclusive integrator and designate its integration branch/checkout. Other workers deliver commits to it. The integrator owns merges and conflict resolution; you review the resulting diff. With one worker, that worker also integrates.
- Share the short plan and honor any requested plan-approval gate before implementation or dispatch. Preparation must not become unauthorized product changes.

## 3. Prove the path, then dispatch independent work

Have the relevant owner deliver the shared interfaces early and implement the smallest real path through the entry point, backend and persistence as applicable. Exercise it before dependent work expands. If it fails, return it to that owner first; independent work can continue.

Each brief stands alone. Include the user's task and constraints, plus only the context needed for that worker's assigned slice. These ownership and acceptance requirements are part of the requested orchestration, not extra restrictions invented by the transport.

```text
Task and constraints: <user request and this worker's deliverable>
Checkout / branch / base: <assigned paths and exact revision>
Ownership: <editable files/components; shared owners; integration owner>
Contracts: <agreed interfaces and required upstream commits>
Acceptance: <observable success, relevant failure/retry/conflict behavior>
Checks: <mandatory local checks and actual entry point>
Handoff: exact changes/commit, evidence, blockers, decisions, unverified criteria.
Do not edit another owner's components, delegate further, or push, merge to
main, deploy or publish. Request shared changes from the coordinator.
```

Use direct Farcall completion waits and batch independent tasks in disjoint checkouts. Do not dispatch consumers of unfinished contracts. Do not poll worker status, tail logs repeatedly or do the same work while waiting. A timeout or interrupted batch has an unknown outcome until reconciled, not permission to launch duplicates.

## 4. Integrate and correct

- Inspect each handoff, including changed paths against ownership, exact session/delegation IDs, actual model/effort evidence, check exit codes and unresolved findings. A completed Farcall call is not task acceptance.
- Resume the exclusive integrator after its dependencies return. It integrates the agreed commits and runs the mandatory checks against the combined result. Shared ownership violations must be reconciled with the owner before integration is accepted.
- Workers keep useful regression tests with the implementation, not only in temporary worker artifacts. No extra suites or CI machinery by default.
- Return corrections to the original worker session with the findings and expected behavior. If that session cannot be resumed, report the limitation before assigning a replacement. Repeated failure calls for a narrower task or a revised decision, never an unannounced model switch.
- Serialize integration with corrections to the integrator's own checkout. Reintegrate corrected commits through the same integrator; do not edit worker code yourself.

## 5. Accept the integrated result

- Read the integrated diff yourself. Check shared ownership, interfaces and evidence. Call this **coordinator review**, not independent review.
- UI tasks require real browser journeys against the real application/backend. Check persisted results by reloading or reading the actual storage/API. Screenshots, mocks and success messages alone do not establish acceptance.
- For other tasks, exercise the actual CLI, API or library entry point and inspect real outputs and state.
- Where relevant, test failed reads/writes, delayed responses, concurrent changes and retries with unchanged and changed input. Preserve unsaved work and never acknowledge changes that were not applied.
- A failed assertion must produce a failed verification result. Missing tools, inaccessible environments and unrun checks remain open; never convert them into a pass.
- Use worker check evidence to target your acceptance work. Own final acceptance without rerunning every full suite. Keep mandatory local checks; after corrections, recheck affected paths and broaden only if the change or failure requires it.

## 6. Report the exact final state

Report the integrated branch/commit, requested and verified models/efforts, what changed, check evidence, coordinator-review findings and unresolved criteria. Distinguish worker-complete, integrated and accepted states. Unverified or failing criteria remain open. No push, main merge, deployment or publishing without approval.
