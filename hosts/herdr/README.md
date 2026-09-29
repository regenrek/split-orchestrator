# Split Orchestrator in herdr (experimental)

[herdr](https://herdr.dev) runs Claude Code in its panes, so the plugin works there as in any terminal: install it as in the [main README](../../README.md), and each Claude Code pane gets the rules, the implementer subagent and the orchestrate skill.

If you use the [herdr-projects](https://github.com/eliasstravik/herdr-projects) plugin, its coordinator starts worker threads from named profiles. [`profiles.toml`](profiles.toml) defines two that match the plugin's split:

| Profile | Model | Effort | Role |
|---|---|---|---|
| `split-lead` | Opus | default | Coordinator |
| `split-worker` | Sonnet | high | Worker threads |

The herdr-projects coordinator picks a profile per thread by its description, so the worker's description says what kind of task belongs there.

Profiles live in `~/.config/herdr-projects/config.toml`, which the coordinator never writes. Add them yourself, or in the Projects popup (`prefix+a`, then settings).

## Status

Experimental: the profile format follows the herdr-projects docs, and the author doesn't use herdr day to day. Reports and pull requests are welcome.
