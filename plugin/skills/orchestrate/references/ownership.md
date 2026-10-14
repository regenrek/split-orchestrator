# One owner per rule

User instructions and approval boundaries apply throughout. These layers own different decisions; priority is not permission for a transport to choose the product workflow.

| Owner | Canonical responsibility |
|---|---|
| Farcall | Installed-version call schema, supported options, direct completion, delegation identity, idempotency, resume, isolation and transport artifacts |
| Split Orchestrator | Roles, model/effort defaults, ownership, review/QA, findings, coordinator continuity, acceptance and run cleanup decisions |
| Host adapters | Locate and load the canonical workflow; document actual host capabilities without copying workflow rules |
| Project instructions | Project commands, component owners, acceptance criteria and explicit, justified task constraints |

Farcall's actual installed contract wins on transport questions. Never recreate its process loops or recovery machinery in a skill. Split calls Farcall tools directly; it does not invoke the standalone worker skill and append a second workflow. See [host setup and contract discovery](farcall.md).

Split's [role and tier reference](review.md) is the maintained model/effort source. Hook rules and user documentation route to it instead of keeping competing tables. Explicit user choices are recorded, never silently substituted. Additional review or planning roles need a named, still-uncovered risk or user request; no blanket chain through another skill.

General orchestration lessons belong here. Project `AGENTS.md` files add project facts and justified requirements, not a copy of Split. A retired orchestration skill should be removed after migrating its useful rules and callers. Keep a loading adapter only for a demonstrated discovery gap; it owns no model, tier or restart policy. Missing Split is a setup issue, never a reason to invent a copied fallback.

Specialist host skills can own capacity leases, device access and target inventory; they refer back here for workflow and to Farcall for transport. The public workflow must stay usable without private host skills.

## Transport scope

Farcall is the default for dispatches made by the Split coordinator. Its no-fallback rule applies to a dispatch assigned to Farcall, not to a host stream whose native delegation was explicitly chosen by the user or authorized project instructions before dispatch. Record scope, source of that choice, exact worker model/effort and transport in the task record. Merely lacking Farcall is not such a choice. A conditional instruction such as "use native if Farcall is unavailable" is a fallback, not preselection under this exception.

A stream lead on an explicitly chosen native path applies the ownership, review and acceptance rules relevant to its role; it does not become root coordinator or need the root's model. Use that host's actual child identifiers, completion waits and recovery contract; never invent Farcall session IDs for native children. Verify isolation, tool access and result delivery. The root Coordinator row in [roles](review.md) is not a stream-lead assignment: the native lead's exact model/effort come from its recorded user/project assignment; worker defaults stay in that reference; a transport choice is not a model change or permission expansion.

Never reroute a pending, failed or unknown Farcall attempt to native or CLI workers under this exception; reconcile the original attempt first. Any later transport change needs explicit authorization and preserved task ownership, with no duplicate execution. Existing no-polling and [continuity](coordination.md) safeguards still apply; for native Codex wait settings see the [host guidance](https://github.com/regenrek/split-orchestrator/blob/main/hosts/bb/README.md#optional-native-codex-waits).
