# Development

[Back to the README](../README.md)

Run `scripts/check.sh` to validate both manifests, lint the shell scripts, check local document links & exercise the session hook and legacy bb-rule cleanup locally. These checks make no model calls and do not validate model judgment. CI runs the same command.

To try the local plugin with a configured Farcall installation, start a new session in a disposable project.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 \
  claude --model claude-opus-5-5 --effort high \
  --plugin-dir /absolute/path/split-orchestrator/plugin
```

The SessionStart hook loads compact coordinator rules. The skill owns the workflow; its Farcall reference owns the transport details. The native Haiku agent handles bounded non-GUI routine checks; Sol handles browser/Electron tests through Farcall; no server or implementer runtime is bundled here.

```text
.claude-plugin/marketplace.json
plugin/
  .claude-plugin/plugin.json
  agents/routine-checker.md
  hooks/hooks.json
  rules/coordinator.md
  skills/orchestrate/
    SKILL.md
    references/farcall.md
    references/acceptance.md
hosts/
  bb/       setup notes & removal of the old custom-instruction block
  herdr/    coordinator setup notes
scripts/check.sh
scripts/check_repository.py
```

See [verification](evaluation.md) for live acceptance scenarios. Historical native-subagent evals remain available at Git tag `v0.1.1`; they are not part of the active plugin.
