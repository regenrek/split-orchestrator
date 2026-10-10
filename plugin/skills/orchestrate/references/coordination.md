# Coordinator continuity

Context maintenance and coordinator replacement are separate operations. Keep authoritative goals, ownership, decisions and acceptance state in existing repository/planning files. A checkpoint links those records; neither the transcript nor its summary is the task database. Do not add a queue service by default.

## Check host capabilities

Before relying on continuity, record the installed host/version and supported behavior for stable session identity, child handles and completion routing, survival of pending calls, cross-session child resume or readdressing, and shared artifact access. Unknown capabilities count as unsupported for the proposed operation. Model/effort evidence marked unknown is a separate matter and does not itself block dispatch.

Prefer compaction in the same thread/session when the host preserves coordinator identity, child ownership and result delivery. Let the host manage context size; there is no mandatory token threshold or daily replacement. Milestones and day boundaries are opportunities to checkpoint and review. Resuming the same session may preserve continuity; a new thread sharing the same root or parent does not itself transfer children.

## Checkpoint and reconcile

Maintain a short checkpoint linking authoritative entries as commitments change. A 2–5k-token index is a useful size guide, not a guarantee against information loss. Include:

- Goals, scope, approvals, acceptance criteria and rejected approaches, with source links.
- Active/queued task IDs, attempt IDs, owners, integration owner and status.
- Dispatch intents and open delegations: exact session/delegation/batch IDs, assigned role/model/effort, checkout and pending/completed/unknown status.
- Decisions, blockers, unresolved outcomes and ordered next actions.
- Exact repository/branch/commit and runtime revisions, dirty work, evidence paths and delivery/recovery routes.
- Current dispatch owner, checkpoint revision, notification cursor and consumed event IDs; named successor only when replacement is intended.

Before a worker call, persist task ID, attempt ID and dispatch intent. After it returns, save returned session/delegation IDs and result/event records. If interrupted between those writes, use the existing recovery evidence to reconcile the attempt; an intent without returned IDs must not trigger another dispatch.

Do not request or run compaction during a pending Farcall wait. Checkpoint before dispatch, keep the direct wait intact, and request manual compaction only after it returns. Do not assume automatic host compaction preserves a Farcall call: if delivery is lost, retain an unknown outcome and recover without launching a replacement worker.

After compaction, reload the checkpoint and reconcile task, delegation and result records before new dispatch. Check persisted intent against returned IDs, consume results once and preserve unresolved attempts. A successful command alone does not prove compaction or recovery succeeded.

## Replace only with safe continuity

Stop new dispatch before replacement. Normally, finish direct waits, let session-bound children finish in their current parent, persist their results and reconcile all outstanding records. Stopped workers alone are not enough. A verified host transfer path may carry ongoing children only if it proves their authorization lineage, completion delivery and recovery across the change. Do not compact a pending Farcall wait or break its completion contract as a shortcut.

Do not assume a fresh coordinator inherits native handles. Re-parent or readdress children only through a verified host mechanism covering permissions/ancestry, queued and late notices, descendants and recovery, not merely a changed tree display. Durable task IDs identify results but do not deliver them: require shared artifact access plus working delivery/recovery before retiring the predecessor.

Name exactly one successor. Transfer dispatch authority once in the authoritative record after prerequisites are met; the successor verifies the checkpoint/revisions and the predecessor remains inactive. The starter sets the [coordinator role settings](review.md#roles-and-settings); missing model/effort proof is unknown, confirmed mismatches stop dispatch. Resolve ambiguous ownership before assigning work. Never redispatch because a notice is missing; use task/attempt IDs and the existing recovery procedure.

If replacement is unsafe, continue in the same thread/session where continuity is supported, or leave a checkpoint and report the limitation. Do not claim a successful transfer, invent host capabilities or change user settings.

## Batch notifications and limit active streams

Children/workers write result files. Notifications contain task/attempt/event ID, outcome, exact revision and artifact link; chat reports remain at most 15 lines. Wake immediately for blockers, decisions or acceptance-ready results. As tunable guidance, batch other progress by milestone or every 10–15 minutes; skip empty batches. Record consumption in the task store, without acknowledgement-only messages. Notify affected owners, not all threads.

Prefer existing deterministic delivery. Never replace direct Farcall waits with model-driven polling; normal tool completions still return normally. Across machines use one authoritative store accessible to relevant owners.

Repeated compaction or expensive reconciliation calls for checking the stream workload and pausing new intake; it never overrides the safe continuity requirements above.

Start with 3–5 actively managed streams and queue additional streams with priority/owner; adapt to workload. Independent workers may remain parallel. A stream needs coordinator decisions; it is not every worker process. Add coordinators only for distinct decision responsibility.
