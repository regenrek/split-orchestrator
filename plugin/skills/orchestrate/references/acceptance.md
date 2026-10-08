# Acceptance evidence

Opus defines expected behavior and applicable scenarios before implementation. Implementers keep reproducible regression tests with the code. A fresh Sol QA session exercises the integrated application; Opus evaluates the diff and evidence and owns acceptance. Haiku handles explicit routine checks, including small non-UI entry-point checks; smoke results do not replace Sol acceptance QA. The coordinator does not click through the browser.

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

Keep reports, logs, screenshots, commands and hashes as evidence, not repository copies, dependencies, build output or database copies. Reference database provisioning/reset commands instead; keep a database copy only when needed to reproduce a finding, and say why.

For each scenario, record:

- Integrated commit(s), clean/dirty state and the checkout used. Relevant uncommitted changes invalidate a claim about that commit alone.
- Running instance, URL/port or exact entry command, and how its build/process maps to that revision. For external services, name the tested version/environment and any provenance limitation.
- Reproducible start/reset instructions and versioned or documented test-data provisioning. No hidden local fixture dependencies.
- Steps, expected behavior, actual behavior, pass/fail and useful artifacts. Assertions must fail the verification command when unmet.
- Persisted outcome checked by reload, API or storage when applicable. Explain non-applicability for checks without persisted state.

QA owns an isolated checkout and runtime state. It may create test evidence; it cannot repair product code. Agree ownership before it adds regression tests, then integrate those tests through the sole integrator.

QA checkouts, containers and test databases belong to the run. Name them with the run ID and list them as created in the coordinator's `artifacts/<run-id>/run.md`. Remove them at run close under the skill's cleanup rules; keep the evidence in the coordinator's `artifacts/<run-id>/`.

After a fix, the coordinator prepares the QA checkout and runtime at the new integrated commit while preserving evidence and unresolved drafts. Resume the original QA session, verify that revision, and repeat affected scenarios plus core journeys. Broaden coverage when shared changes or new failures justify it. Opus reviews actual evidence and assigns gaps, contradictions and pre-marked risks to Sol QA for targeted live rechecks. Keep chat handoffs within 15 lines and link the detailed report.

Keep failures and missing evidence open. A budget limit is a stopping condition, never a pass.
