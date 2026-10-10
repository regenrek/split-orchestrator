# Acceptance evidence

The [selected review tier and roles](review.md) determine who verifies the change. The coordinator defines expected behavior, examines relevant risks/findings and actual evidence, and owns final acceptance. Implementers keep reproducible regression tests. Assigned QA exercises the integrated application without repairing product code; smoke alone is not acceptance. Trivial changes use their tier's local checks, not an automatic extra QA/reviewer chain.

## Browser and Electron smoke

Use the [smoke role settings](review.md#roles-and-settings) for smoke sessions with a short fixed checklist and verified browser/Electron access in that session. Record the revision, running instance, named viewport, expected/actual outcomes and evidence. Assert no unintended element extends beyond the viewport and no unintended horizontal overflow; document intended scroll regions. Screenshots alone do not prove these assertions. Keep smoke separate from acceptance QA and never route GUI work to Haiku or the coordinator.

Spot-check the first medium smoke runs with a separate Sol-high acceptance session using the same cases, revision, runtime and test data. Compare reproducible findings in the evidence. If medium finds substantially fewer issues, return smoke to high and record why; do not silently change settings. Medium is never sufficient for acceptance QA. This is an initial validation of the effort choice, not a duplicate full pass on every run.

## Stateful scenarios

Select cases relevant to the feature. Document why a case is not applicable rather than inventing unrelated requirements.

| Scenario | Required outcome |
|---|---|
| Retry with unchanged or changed input | An identical retry follows the agreed idempotency contract. Reusing an operation ID with changed content cannot report success for changes that were never stored. Reject the mismatch or apply the documented contract; verify storage. |
| Failed read, refresh or write | Unsaved input stays visible and recoverable. A failed refresh or filter change must not discard the draft. A failed save must not claim success. |
| Delayed save response | Start saving, edit again while the response is delayed, then release it. Newer input survives; the UI distinguishes the saved version from the still-unsaved changes. |
| Concurrent status change | A second independent browser context/session changes the same record's status. Conflict handling and reloading preserve access to the first session's local draft. Do not assume stale changes may overwrite the new state. |

For every applicable case, the success/error message, displayed state and persisted data must agree. Preserve unsaved work; never acknowledge unapplied changes.

## Reproducible evidence

Before a long or expensive run, check the target, tools and capacity, then exercise one small case through the same harness. A failed precheck must be classified and corrected before expanding the run. Desktop evidence records platform, build identity and launch method, with a window capture while visible and unoccluded.

Keep reports, logs, screenshots, commands and hashes as evidence, not repository copies, dependencies, build output or database copies. Reference database provisioning/reset commands instead; keep a database copy only when needed to reproduce a finding, and say why.

For each scenario, record:

- Integrated commit(s), clean/dirty state and the checkout used. Relevant uncommitted changes invalidate a claim about that commit alone.
- Running instance, URL/port or exact entry command, and how its build/process maps to that revision. For external services, name the tested version/environment and any provenance limitation.
- Reproducible start/reset instructions and versioned or documented test-data provisioning. No hidden local fixture dependencies.
- Steps, expected behavior, actual behavior, pass/fail and useful artifacts. Assertions must fail the verification command when unmet.
- Persisted outcome checked by reload, API or storage when applicable. Explain non-applicability for checks without persisted state.

QA owns an isolated checkout and runtime state. It may create test evidence; it cannot repair product code. Agree ownership before it adds regression tests, then integrate those tests through the sole integrator.

QA checkouts, containers and test databases belong to the run. Name them with the run ID and list them as created in the coordinator's `artifacts/<run-id>/run.md`. Remove them at run close under the skill's cleanup rules; keep the evidence in the coordinator's `artifacts/<run-id>/`.

After a fix, the coordinator prepares the QA checkout and runtime at the new integrated commit while preserving evidence and unresolved drafts. Resume the original QA session, verify that revision, and repeat affected scenarios plus core journeys. Broaden coverage when shared changes or new failures justify it. Opus inspects relevant evidence portions and assigns gaps, contradictions and pre-marked risks to Sol QA for targeted live rechecks. Where required by the tier, the diff reviewer covers fixes and affected interactions at the final revision under the [findings contract](review.md#review-and-findings); Opus deepens targeted inspection for unresolved findings without routinely reloading all artifacts. Keep chat handoffs within 15 lines and link the detailed report.

Keep failures and missing evidence open. A budget limit is a stopping condition, never a pass.
