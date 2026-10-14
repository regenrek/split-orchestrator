# Coordinator continuity

Context maintenance and coordinator replacement are separate operations. Keep authoritative goals, ownership, decisions and acceptance state in existing repository/planning files. A checkpoint links those records; neither transcript nor summary is the task database. No queue service by default.

## Check host capabilities

Before relying on continuity, record installed host/version and supported behavior for: stable session identity, child handles and completion routing, survival of pending calls, cross-session child resume or readdressing, shared artifact access. Unknown capabilities count as unsupported for the proposed operation. Model/effort evidence marked unknown is a separate matter and does not itself block dispatch.

Prefer same thread/session compaction when the host preserves coordinator identity, child ownership and result delivery. Host manages context size; no mandatory token threshold or daily replacement. Milestones and day boundaries are checkpoint and review opportunities. Resuming the same session may preserve continuity; a new thread sharing the same root or parent does not itself transfer children.

## Checkpoint and reconcile

Keep a short checkpoint linking authoritative entries, updated as commitments change. 2–5k-token index is a size guide, not a guarantee against information loss. Include:

- Goals, scope, approvals, acceptance criteria and rejected approaches, with source links.
- Active/queued task IDs, attempt IDs, owners, integration owner and status.
- Dispatch intents and open delegations: exact session/delegation/batch IDs, assigned role/model/effort, checkout, pending/completed/unknown status.
- Decisions (ledger), blockers, unresolved outcomes and ordered next actions.
- Exact repository/branch/commit and runtime revisions, dirty work, evidence paths and delivery/recovery routes.
- Current dispatch owner, checkpoint revision, notification cursor and consumed event IDs; named successor only when replacement is intended.

Before a worker call persist task ID, attempt ID and dispatch intent. After it returns save returned session/delegation IDs and result/event records. If interrupted between those writes, reconcile the attempt from existing recovery evidence; an intent without returned IDs must not trigger another dispatch. Native and host-thread starts: check the host's thread or session list for the attempt first; a start reported as aborted may exist.

Never request or run compaction during a pending Farcall wait. Checkpoint before dispatch, keep the direct wait intact, request manual compaction only after it returns. Do not assume automatic host compaction preserves a Farcall call: if delivery is lost, keep the outcome unknown and recover without launching a replacement worker.

After compaction reload the checkpoint and reconcile task, delegation and result records before new dispatch. Check persisted intent against returned IDs, consume results once, preserve unresolved attempts. A successful command alone does not prove compaction or recovery succeeded.

## Replace only with safe continuity

Stop new dispatch before replacement. Normally finish direct waits, let session-bound children finish in their current parent, persist their results and reconcile all outstanding records; stopped workers alone are not enough. A verified host transfer path may carry ongoing children only if it proves their authorization lineage, completion delivery and recovery across the change. Never compact a pending Farcall wait or break its completion contract as a shortcut.

Do not assume a fresh coordinator inherits native handles. Re-parent or readdress children only through a verified host mechanism covering permissions/ancestry, queued and late notices, descendants and recovery, not merely a changed tree display. Durable task IDs identify results but do not deliver them: require shared artifact access plus working delivery/recovery before retiring the predecessor.

Name exactly one successor. Transfer dispatch authority once in the authoritative record after prerequisites are met; successor verifies checkpoint/revisions; predecessor stays inactive. Starter sets the [coordinator role settings](review.md#roles-and-settings); missing model/effort proof is unknown, confirmed mismatches stop dispatch. Resolve ambiguous ownership before assigning work. Never redispatch because a notice is missing; use task/attempt IDs and the existing recovery procedure.

If replacement is unsafe, continue in the same thread/session where continuity is supported, or leave a checkpoint and report the limitation. Never claim a successful transfer, invent host capabilities or change user settings.

## Batch notifications and limit active streams

Children/workers write result files. Status by pull: notify only for STOP, decision or acceptance-ready result; other progress stays in result files, read by the coordinator on wake. Notifications contain task/attempt/event ID, outcome, exact revision and artifact link; chat reports at most 15 lines. Consume each event once; progress plus completion notice for the same event triggers one handling. No turn for duplicate or progress-only notices. Record consumption in the task store, without acknowledgement-only messages. Notify affected owners, not all threads. Record each native or host-thread worker's expected finish and arrange one bounded host wake at that time; if no notice arrived, read its result file and session status once and consume a found result once. Direct Farcall waits stay unpolled; a missing notice never authorizes redispatch.

On each wake reconcile arrived decisions and results first, then fill free stream slots with ready independent work from the plan. Plan model, provider, test-VM, GUI and build capacity separately; free model capacity is not free test capacity. Shared test-VM slots: the integration path has priority; long acceptance or performance runs yield or use their own slot. On repeated provider overload reduce new starts and secure running results instead of queueing more acceptance work.

Prefer existing deterministic delivery. Never replace direct Farcall waits with model-driven polling; normal tool completions still return normally. Across machines use one authoritative store accessible to relevant owners.

Repeated compaction or expensive reconciliation: check stream workload and pause new intake; never overrides the safe continuity requirements above.

Start with 3–5 actively managed streams; queue additional streams with priority/owner; adapt to workload. Independent workers may stay parallel. A stream needs coordinator decisions; it is not every worker process. Add coordinators only for distinct decision responsibility.
