# Keep coordinators small

[Back to usage](usage.md)

Conversation history and frequent wakeups accumulate even when repository files stay the same size. Keep authoritative work in repository or planning files, rotate the model session and send fewer notifications. These are workflow instructions; the plugin does not enforce token ceilings, create successors automatically or change user configuration.

Start preparing a handoff near 150k context tokens. Rotate near 200k, after a completed milestone or at least daily during active work, whichever comes first. Start fresh with a 2–5k-token handoff; do not resume or fork the old transcript. These are starting values, not measured optima. Required startup instructions may make total initial context larger than the handoff itself.

The [continuity contract](../plugin/skills/orchestrate/references/coordination.md) specifies goals, task IDs, owners, exact delegation/session IDs, linked decisions, blockers, next actions and revisions. It also covers one-owner dispatch transfer, pending calls and late results. Keep 3–5 active streams per coordinator and queue the rest; independent workers can remain parallel. Results go to files. Wake immediately for blockers, decisions or acceptance-ready results; batch other progress by milestone or every 10–15 minutes. No acknowledgement-only messages or broadcasts to unaffected threads.

## Optional compaction settings

Recommendation only: consider merging this key into `~/.claude/settings.json`, preserving existing settings:

```json
{
  "autoCompactWindow": 200000
}
```

Alternatively, use `/autocompact 200k` or set `CLAUDE_CODE_AUTO_COMPACT_WINDOW=200000` in the launcher. The environment variable takes precedence. Current Claude Code saves the slash command per model; a per-model value can override the top-level key. Check the installed version and effective settings. [Claude Code compaction controls](https://code.claude.com/docs/en/model-config#set-the-auto-compact-window).

Earlier compaction reduces retained context, but summarization adds work and can lose details. It bridges a task; a fresh coordinator still needs durable ownership and decisions. Avoid repeated tiny compactions. The thread starter sets Opus effort to `high`; the coordinator reports mismatches rather than silently continuing. This plugin writes none of these settings and does not restart sessions.

## Cache duration

Within subscription allowance, the main conversation defaults to a one-hour cache. Usage credits beyond the allowance default to five minutes. A custom `ANTHROPIC_BASE_URL` or gateway can fall back to five minutes or impair caching; check forwarding and actual usage rather than assuming subscription defaults apply. [Claude Code prompt caching](https://code.claude.com/docs/en/prompt-caching).

`promptCacheTtl` controls the main conversation; `subagentPromptCacheTtl` controls requests outside it. Both accept `5m` or `1h` in supported versions. Longer TTL can help after pauses, but has higher API cache-write cost. Environment overrides, including `FORCE_PROMPT_CACHING_5M`, can take precedence. Inspect `usage.cache_creation.ephemeral_1h_input_tokens` and `ephemeral_5m_input_tokens` in an existing JSON result to verify write duration. Zero writes do not prove the configured TTL. [TTL settings and verification](https://code.claude.com/docs/en/prompt-caching#choose-the-ttl-yourself).

## Evaluate the starting values

Compare similar workloads using coordinator calls per accepted deliverable, context percentiles and cache writes by TTL. Record missed decisions, duplicate dispatch and handoff recovery failures as well as usage. No savings or handoff reliability is established merely by installing these instructions.
