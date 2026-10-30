# Acceptance evidence

The [selected review tier and roles](review.md) determine who verifies the change. Coordinator defines expected behavior, examines relevant risks/findings and actual evidence, owns final acceptance. Implementers keep reproducible regression tests. Assigned QA exercises the integrated application without repairing product code; smoke alone is not acceptance. Trivial changes use their tier's local checks, no automatic extra QA/reviewer chain.

## Browser and Electron smoke

Smoke sessions use the [smoke role settings](review.md#roles-and-settings), a short brief, fixed checklist and verified browser/Electron access in that session. Record revision, running instance, named viewport, expected/actual outcomes and evidence. Assert no unintended element extends beyond the viewport and no unintended horizontal overflow; document intended scroll regions. Screenshots alone do not prove these assertions. Keep smoke separate from acceptance QA; never route GUI work to Haiku or the coordinator.

Spot-check the first medium smoke runs with a separate Terra-high acceptance session on the same cases, revision, runtime and test data; compare reproducible findings in the evidence. If medium finds substantially fewer issues, return smoke to high and record why; never silently change settings. Medium is never sufficient for acceptance QA. Initial validation of the effort choice, not a duplicate full pass on every run.

## Stateful scenarios

Select cases relevant to the feature. Document why a case is not applicable rather than inventing unrelated requirements.

| Scenario | Required outcome |
|---|---|
| Retry with unchanged or changed input | An identical retry follows the agreed idempotency contract. Reusing an operation ID with changed content cannot report success for changes that were never stored. Reject the mismatch or apply the documented contract; verify storage. |
| Failed read, refresh or write | Unsaved input stays visible and recoverable. A failed refresh or filter change must not discard the draft. A failed save must not claim success. |
| Delayed save response | Start saving, edit again while the response is delayed, then release it. Newer input survives; the UI distinguishes the saved version from the still-unsaved changes. |
| Concurrent status change | A second independent browser context/session changes the same record's status. Conflict handling and reloading preserve access to the first session's local draft. Do not assume stale changes may overwrite the new state. |

For every applicable case, success/error message, displayed state and persisted data must agree. Preserve unsaved work; never acknowledge unapplied changes.

## Reproducible evidence

Before a long or expensive run, check target, tools and capacity, then exercise one small case through the same harness. Run every new or changed check once locally against real stored data (existing stored test data or read-only access to the real target; no production copies) before any test-VM or remote run; no untested check goes to a VM. A new check also fails once against a known-bad state before it counts as evidence. A check that cannot run locally runs once on the smallest single target first. Classify and correct a failed precheck before expanding the run. After two harness/setup aborts before the first successful relevant user path, stop the large run: owner repairs prerequisites in one bundled pass or picks an equivalent existing check path; no full matrix until the small case passes. Count per user path, not per file or finding. A full run collects every red result before reporting; no stop at the first red unless the run endangers data or the reserve. Debug runs never count as final acceptance. Desktop evidence records platform, build identity and launch method, with a window capture while visible and unoccluded.

No seals, checksum chains or not-run ledgers for intermediate states or test reports; checksums only on real install and release artifacts and on evidence kept outside Git. A failure class seen before becomes a checkpoint in the project recipe (`AGENTS.md` or runbook); the coordinator adds it or assigns it with file ownership.

Keep reports, logs, screenshots, commands and commit hashes as evidence; no repository copies, dependencies, build output or database copies. Reference database provisioning/reset commands instead; keep a database copy only when needed to reproduce a finding, and say why.

For each scenario record:

- Integrated commit(s), clean/dirty state and checkout used. Relevant uncommitted changes invalidate a claim about that commit alone.
- Running instance, URL/port or exact entry command, and how its build/process maps to that revision. External services: tested version/environment and any provenance limitation.
- Reproducible start/reset instructions and versioned or documented test-data provisioning. No hidden local fixture dependencies.
- Steps, expected behavior, actual behavior, pass/fail and useful artifacts. Assertions must fail the verification command when unmet.
- Persisted outcome checked by reload, API or storage when applicable; explain non-applicability for checks without persisted state.

QA briefs state invariants and observable outcomes with their spec or contract source, not exact error codes or precedence unless the contract fixes them; an expectation without a source is an open question, not a failure criterion. QA may retest the pre-rebase head in parallel with integration; one range diff plus one full run on the rebased head then prove the rebase.

QA owns an isolated checkout and runtime state, with test accounts and test data only; never production credentials, data or deploy access. It may create test evidence; never repairs product code. Agree file ownership before it adds regression tests, then integrate those tests through the sole integrator before final checks.

QA checkouts, containers and test databases belong to the run: name them with the run ID and list them when created in the coordinator's `artifacts/<run-id>/run.md`. Remove them at run close under the skill's cleanup rules; keep evidence in the coordinator's `artifacts/<run-id>/`.

After a fix the coordinator prepares QA checkout at the new integrated commit and restarts/rebinds its runtime, preserving evidence and unresolved drafts. Resume the original QA session; QA verifies checked-out hash and runtime revision, then repeats affected scenarios plus core journeys; broaden when shared changes or new failures justify it. Coordinator inspects relevant evidence portions and assigns gaps, contradictions and pre-marked risks to Terra QA for targeted live rechecks. Where the tier requires, the diff reviewer covers fixes and affected interactions at the final revision under the [findings contract](review.md#review-and-findings); coordinator deepens targeted inspection for unresolved findings without routinely reloading all artifacts. Chat handoffs within 15 lines, linking the detailed report.

Keep failures and missing evidence open. A budget limit is a stopping condition, never a pass.
