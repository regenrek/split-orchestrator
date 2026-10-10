# One owner per rule

User instructions and approval boundaries apply throughout. These layers own different decisions; priority is not permission for a transport to choose the product workflow.

| Owner | Canonical responsibility |
|---|---|
| Farcall | Installed-version call schema, supported options, direct completion, delegation identity, idempotency, resume, isolation and transport artifacts |
| Split Orchestrator | Roles, model/effort defaults, ownership, review/QA, findings, coordinator continuity, acceptance and run cleanup decisions |
| Host adapters | Locate and load the canonical workflow; document actual host capabilities without copying workflow rules |
| Project instructions | Project commands, component owners, acceptance criteria and explicit, justified task constraints |

Farcall's actual installed contract wins on transport questions. Do not recreate its process loops or recovery machinery in a skill. Split calls Farcall tools directly; it does not invoke the standalone worker skill and then append a second workflow to it. See [host setup and contract discovery](farcall.md).

Split's [role and tier reference](review.md) is the maintained model/effort source. Hook rules and user documentation route to it instead of maintaining competing tables. Explicit user choices are recorded, never silently substituted. Additional review or planning roles need a task-specific purpose; do not add a blanket chain through another skill.

General orchestration lessons belong here. Project `AGENTS.md` files add project facts and justified requirements rather than reproducing Split. A retired orchestration skill should be removed after its useful rules and callers have been migrated. Keep a loading adapter only for a demonstrated discovery gap; it owns no model, tier or restart policy. Missing Split is a setup issue, not a reason to invent a copied fallback.

Specialist host skills can own capacity leases, device access and target inventory. They refer back here for workflow and to Farcall for transport. The public workflow must remain usable without private host skills.
