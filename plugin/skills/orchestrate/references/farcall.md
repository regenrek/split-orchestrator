# Farcall integration

Farcall is a separately installed dependency and the canonical owner of its call schema, supported options, waits, IDs/idempotency, resume, isolation and transport artifacts. Split calls its tools directly, rather than invoking the standalone Farcall worker skill. Split supplies task ownership and acceptance criteria as part of the user-authorized orchestration.

## Resolve the actual contract

Before dispatch, identify the installed adapter/plugin version and available `codex_worker` tools. Consult that version's [installation](https://github.com/regenrek/farcall-mcp/blob/main/docs/installation.md), [usage](https://github.com/regenrek/farcall-mcp/blob/main/docs/usage.md) and [batch/recovery contract](https://github.com/regenrek/farcall-mcp/blob/main/docs/batches.md). These links show current upstream documentation; select the corresponding tag or commit for the installed artifact. A version label alone is insufficient for a modified cache: record its source revision or hash when diagnosing a mismatch. Do not replace installed-version facts with a stale checkout or assume a running session reloaded an updated plugin.

Keep the parent configured for a direct pending MCP call according to Farcall's host instructions. Tool namespaces vary by host. Verify the required single and batch capabilities instead of maintaining another argument schema here. A missing tool, permission or delivery channel is a setup problem, not permission to substitute native workers, poll or run a CLI fallback.

## Split's dispatch responsibilities

- Choose role/model/effort under the [canonical roles and tiers](review.md), including the distinct medium-effort cases for trivial implementation and fixed-checklist smoke. Do not apply a smoke-only effort validator to trivial implementation.
- Prepare a standalone brief, exact checkout/base, exclusive ownership and expected evidence. Use the installed tool's file-brief facility for long instructions. Keep writable areas disjoint; independent deliverables may batch, integration follows dependencies.
- Persist task/attempt/dispatch intent under the [continuity contract](coordination.md). Give the transport exact IDs and consume the returned result once. A missing notice or uncertain outcome is not grounds for replacement work.
- Wait directly. Follow Farcall's actual recovery status and records after interruption/timeout. Do not equate an unobserved result with failure or a completed CLI with product acceptance. Resume only the identified original session under the installed contract.
- Return concise handoffs with final revision, findings, check evidence and artifact paths. If a preview is truncated or externalized, read the needed result-file sections; do not import complete logs or rerun merely to retrieve a longer answer.

## Checkout permissions and QA access

Use isolated local clones for workers needing independent Git metadata, or an appropriate worktree when its permissions are verified. With a local clone, Git can hardlink immutable objects; do not copy repositories, dependencies or build output. Reuse correction checkouts and remove only run-owned resources under [cleanup](../SKILL.md#6-report-the-exact-final-state).

An extra writable root is not a permission bypass or a guarantee that Git commits work. Before assigning commits, verify authorized Git-write access for the actual CLI, OS, checkout and Git metadata layout. A linked worktree's `.git` may be a file, not a directory accepted by the adapter. Do not grant a shared Git common directory blindly, assume a plain clone resolves every sandbox restriction, or escalate permissions automatically. If the required commit cannot be made, keep the criterion open and report the specific permission gap.

Browser/Electron smoke and acceptance QA have separate sessions, checkouts and mutable runtime state. Verify tools in the assigned session; parent browser connections are not inherited. Prepare/rebind the QA checkout and runtime to the new integrated revision before an exact-session recheck, preserving evidence and unsaved work. QA never repairs product code. See [acceptance](acceptance.md).

## Evidence boundaries

Scope execution-evidence reads to the returned session/delegation IDs; do not inspect unrelated sessions. Record selected settings and available adapter/provider evidence separately. Missing model evidence is unknown, a confirmed mismatch stops settings-dependent dispatch. Requested settings or model self-description do not independently prove the served model. Check the actual installed result contract rather than assuming fields or billing behavior. Do not infer API billing from use of Farcall.

Keep completion/recovery records and any necessary resumable-session artifacts before deleting a worker checkout. Optional raw traces remain worker evidence; retention decisions belong to Split's cleanup contract, while their storage format and transport identity belong to Farcall.
