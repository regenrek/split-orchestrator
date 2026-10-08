# Coordinator continuity

The repository or planning files hold authoritative goals, ownership, decisions and acceptance state. A transcript or handoff summary is not the task database. Use the existing task store; do not add a queue service or new automation by default.

## Bound each session

Prepare a handoff at about 150,000 context tokens. Start a fresh coordinator around 200,000, after a completed milestone, or at least daily during active work, whichever comes first. These thresholds are starting values, not validated optima or automatic runtime limits. Use available context telemetry; if unavailable, report that and use milestone/daily boundaries instead of inventing a count. Compaction is a safety net within a task, not a replacement for rotation.

Write a 2,000–5,000-token handoff file. Load it and required instructions into the successor; do not resume or fork the large transcript. Link detail rather than copying it. Record:

- Goals, scope, approval gates and acceptance criteria, with authoritative file paths.
- Active and queued task IDs, owners, integration owner and current status.
- Open delegations: task ID, exact session/delegation IDs, assigned role/model/effort, checkout, pending/completed/unknown status and evidence/recovery paths. Preserve batch IDs when applicable.
- Decisions with links, blockers, unresolved criteria and ordered next actions.
- Exact repository/branch/commit and runtime revisions; dirty work and evidence limitations.
- Dispatch owner, named successor, handoff revision, notification cursor and consumed event IDs.

## Transfer dispatch once

1. Stop new dispatch and checkpoint the authoritative files. Name one successor, leaving dispatch inactive during transfer. The thread starter launches it fresh as Opus/high; the successor verifies settings before dispatch. Use only the host's authorized session mechanism. If unavailable, leave the handoff ready and report the limitation, not a successful rotation.
2. Preserve direct Farcall completion waits. Do not interrupt a pending call to satisfy the token target, inspect pending logs, or launch replacement work. Finish the wait before transfer; unknown outcomes remain open for the existing recovery procedure. Mark any delay to the rotation target.
3. The successor checks the handoff against authoritative files/revisions and records that it owns dispatch. The predecessor stays inactive; neither another successor nor the predecessor may dispatch. If ownership is ambiguous, resolve it before assigning work.
4. Route late results to their durable task IDs and evidence paths, not to an old chat as the only record. Never redispatch a task merely because its result arrived after rotation. Record result consumption and ignore duplicate event IDs. Retain the cursor in the next handoff. Across machines, use one authoritative store accessible to all relevant owners; local copies alone do not guarantee shared ownership.

## Batch notifications

Children and workers write results to assigned files. Notifications contain task/event ID, outcome, exact revision and artifact link; chat reports remain at most 15 lines. Wake the coordinator immediately only for a blocker, a decision requiring it, or a result ready for acceptance. Other progress is collected per milestone or at a chosen interval of 10–15 minutes, never more often between milestones. Skip empty batches.

Record consumption in the task store; do not send acknowledgement-only messages. Notify affected owners only, not every thread. Prefer existing deterministic delivery/batching mechanisms. Do not add model-driven polling or replace Farcall's direct completion wait with notification polling. Mandatory tool completions still return normally; avoid extra progress wakeups around them.

## Bound active streams

Manage 3–5 active streams per coordinator; queue additional streams with priority and owner. Workers can still run independent tasks in parallel under the ownership and integration rules. A stream is a deliverable needing coordinator decisions, not every worker process. Add a coordinator only for a distinct decision responsibility; do not create another layer just to forward messages.
