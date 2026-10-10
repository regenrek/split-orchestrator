# Integrated review and coordinator acceptance

Pick the change class before dispatch and write it into the brief. Review and QA follow the tier; an explicit user/project reviewer choice (including Astra) replaces the reviewer column only.

| Class | Examples | Build | Review | QA |
|---|---|---|---|---|
| trivial | copy, config, test-only, one file, no shared contract | Sol medium | local checks only | implementer's checks |
| normal | feature slice, fix touching shared types | Sol high | `gpt-6.1-sol` high or chosen reviewer, full diff | Sol QA on the real entry path when behaviour changed |
| security / money / data | auth, payments, persistence, migrations, exports | Sol high | full diff review, then a strong-model final review | fresh Sol QA with persisted-state checks |
| UI | visible layout or interaction change | Sol high from a design brief | full diff review high, plus one bounded UI review pass by a strong UI model run natively (screenshots, about 50 calls) | browser QA, named viewport, screenshots |

Give the reviewer the requirements, acceptance criteria, exact base and integrated head commits, changed-file inventory and evidence paths. It must cover the full diff and relevant surrounding code for correctness, ownership, interface compatibility and regressions. It must disclose any unreviewed portion, unavailable evidence or truncated input. Do not treat an incomplete review as complete. The reviewer does not fix product code; findings return to the original owners through the integrator.

Return at most 15 chat lines: exact reviewed base/head, coverage and verdict, blocking findings, test evidence (including unrun checks), unresolved risks/decisions and detailed artifact path. Keep full logs/traces in worker artifacts, subject to the existing retention rules. If findings exceed the summary budget, report counts/severity and index them in the artifact; never omit a blocker to meet the line limit.

Opus owns final acceptance. Inspect the findings/index and targeted test evidence, then relevant, risky or contradictory diff hunks and their surrounding code. Deepen inspection and request focused clarification or rechecks for open findings, inconsistent evidence, missing coverage or newly discovered risks. A green reviewer summary alone is insufficient. Do not routinely import the complete diff again or read every artifact in full. Load only the referenced portions needed to resolve decisions; expand coverage when the evidence warrants it.

Bind review and QA evidence to the final integrated revision. After fixes, have the reviewer check the changed delta and affected interactions, broaden when warranted, and record carried-forward coverage plus the new head. A changed or unexplained base invalidates that carry-forward. Keep unresolved findings and acceptance criteria open. Label the separate diff review and Opus's coordinator acceptance accurately; neither replaces the other or live QA.
