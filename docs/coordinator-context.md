# Keep coordinators small

[Back to usage](usage.md)

Context maintenance does not require a new coordinator. Prefer compaction in the same thread/session when the host preserves identity, child ownership and result delivery. Let the host manage context size; there are no required token thresholds or daily replacements. Milestones and day boundaries prompt checkpoint/review, not automatic rotation.

Before relying on continuity, check stable session identity, child handles/delivery, pending-call survival, cross-session resume/readdressing and shared artifacts. Unknown capabilities are unsupported. Keep a short checkpoint linking authoritative task/decision records. After compaction, reload it and reconcile tasks, delegations and results before dispatch. Persist task/attempt IDs and dispatch intent before a worker call, then returned IDs and consumed events afterward. Do not compact during a pending Farcall wait; request it after the direct wait returns.

The [continuity contract](../plugin/skills/orchestrate/references/coordination.md) covers safe replacement. Normally all direct waits and session-bound children must finish, with results durably collected and reconciled. A verified host transfer may preserve ongoing work, but shared ancestry alone is insufficient. Exactly one successor receives dispatch authority; its predecessor stays inactive. Missing notices never justify redispatch. If continuity is unsafe, stay in the supported session or leave a checkpoint and report the limitation.

Use 3–5 active streams and milestone/10–15-minute notification batches as adjustable guidance. Workers remain parallel. Notify only affected owners, immediately for blockers, decisions or acceptance-ready results. No acknowledgement-only chats. These are instructions, not a queue/session runtime or a configuration installer.

## Host notes

### Plain Claude Code

Keep the same coordinator session. Use host auto-compaction or a user-invoked `/compact` at a safe break. Main-session compaction preserves subagent transcripts; resuming the same session can resume its subagents. A new session cannot assume those handles work. Reload and reconcile the checkpoint before more work. [Subagent persistence](https://code.claude.com/docs/en/sub-agents#resume-subagents).

### SDK and non-interactive hosts

The application must expose the control. Check `system/init.slash_commands`, send `/compact` into the existing conversation and verify a `compact_boundary` system event. A successful result without that event may mean insufficient history to compact. Plugin prose cannot issue this host operation by itself. Never send compaction concurrently with a Farcall wait. [SDK compaction](https://code.claude.com/docs/en/agent-sdk/slash-commands#compact-history-with-compact).

### Agent Teams

Teams are distinct from native subagents. Leadership cannot transfer, and resuming a session does not restore in-process teammates. Keep the running lead, or finish the work, collect/reconcile results and shut down the team before replacing it. [Agent Teams limitations](https://code.claude.com/docs/en/agent-teams#limitations).

### Optional: bb

Keep the coordinator thread as the parent of its host-managed children. Child re-parenting is currently unsupported by this workflow: authorization-lineage checks across the change have not been verified. A new thread under the same root or an updated sidebar tree does not prove delivery. See the [bb continuity notes](../hosts/bb/README.md#coordinator-continuity).

## Optional compaction settings

Optional example for the user, not a required threshold: consider merging this key into `~/.claude/settings.json`, preserving existing settings:

```json
{
  "autoCompactWindow": 200000
}
```

The user can alternatively use `/autocompact 200k` or set `CLAUDE_CODE_AUTO_COMPACT_WINDOW=200000` in the launcher. The environment variable takes precedence. From Claude Code v2.1.288, the slash command saves per model; older versions save the global `autoCompactWindow`. A per-model value can override the top-level key. Check the installed version and effective settings. [Claude Code compaction controls](https://code.claude.com/docs/en/model-config#set-the-auto-compact-window).

Compaction reduces retained context, but summarization adds work and can lose details. Reload authoritative records afterward and avoid repeated tiny compactions. The coordinator must not run `/autocompact` itself: it saves user settings. The thread starter sets Opus effort to `high`; the coordinator reports mismatches rather than silently continuing. This plugin writes none of these settings and does not restart sessions.

## Cache duration

Within subscription allowance, the main conversation defaults to a one-hour cache. Usage credits beyond the allowance default to five minutes. A custom `ANTHROPIC_BASE_URL` or gateway can fall back to five minutes or impair caching; check forwarding and actual usage rather than assuming subscription defaults apply. [Claude Code prompt caching](https://code.claude.com/docs/en/prompt-caching).

`promptCacheTtl` controls the main conversation; `subagentPromptCacheTtl` controls requests outside it. Both require Claude Code v2.1.242+ and accept `5m` or `1h`. Longer TTL can help after pauses, but has higher API cache-write cost. Environment overrides, including `FORCE_PROMPT_CACHING_5M`, can take precedence. Inspect `usage.cache_creation.ephemeral_1h_input_tokens` and `ephemeral_5m_input_tokens` in an existing JSON result to verify write duration. Zero writes do not prove the configured TTL. [TTL settings and verification](https://code.claude.com/docs/en/prompt-caching#choose-the-ttl-yourself).

## Evaluate continuity

Compare similar workloads using coordinator calls per accepted deliverable, context percentiles and cache writes by TTL. Record missed decisions, duplicate dispatch and handoff recovery failures as well as usage. No savings or handoff reliability is established merely by installing these instructions.
