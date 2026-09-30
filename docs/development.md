# Development

[Back to the README](../README.md)

- Try local changes with `claude --plugin-dir ./plugin`.
- [`scripts/check.sh`](../scripts/check.sh) validates the plugin and marketplace, lints the shell scripts and makes sure the worker's model and effort (Sonnet, high effort) read the same everywhere. CI runs it on every push.

```
.claude-plugin/marketplace.json   marketplace entry for /plugin install
plugin/
  .claude-plugin/plugin.json
  rules/coordinator.md            delegation rules, loaded by the hook
  hooks/hooks.json                SessionStart hook
  agents/implementer.md           the worker subagent
  skills/orchestrate/SKILL.md     /split-orchestrator:orchestrate
  evals/                          claude plugin eval suite
hosts/
  bb/                             child-thread instructions and installer
  herdr/                          herdr-projects profiles
scripts/check.sh
```
