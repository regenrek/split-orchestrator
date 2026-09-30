# Usage & models

[Back to the README](../README.md)

## Install from your shell

```sh
claude plugin marketplace add regenrek/split-orchestrator
claude plugin install split-orchestrator@split-orchestrator
```

Start a new session afterwards. The plugin was tested with Claude Code 2.1.284, where the `sonnet` alias resolved to Sonnet 5.5.

## Use

Run your main session on Opus, then work as usual:

```bash
claude --model opus
```

- **Everyday work:** small and mid-size tasks usually stay with the coordinator. It keeps small edits, design questions and anything unclear, and hands off clearly scoped work only when that's clearly bigger than the brief.
- **A large task:** `/split-orchestrator:orchestrate migrate the billing module to the new payments API`
- **Delegation on request:** ask for it ("give each module its own subagent"), or call the agent directly with `@agent-split-orchestrator:implementer`.

## How the coordinator decides

| Delegate to the implementer | Keep in the main session |
|---|---|
| A feature slice, bug fix, tests or docs with known files and a checkable done criterion | Open-ended design, unclear requirements, decisions that span modules |
| Work clearly bigger than the brief it needs | Edits where the brief would be as long as the work |
| Independent slices with separate files, in parallel | Slices that touch the same files (those run one after another) |

Every brief states the goal, context, the files the implementer may edit, the interfaces to use, constraints, done criteria and the exact check to run. When an implementer reports a blocker, the coordinator makes the decision. At the end, the coordinator reads every diff, compares the slices' assumptions and runs the checks on the integrated result, not just the per-slice ones.

The full rules are in [`plugin/rules/coordinator.md`](../plugin/rules/coordinator.md), the implementer in [`plugin/agents/implementer.md`](../plugin/agents/implementer.md), and the orchestration steps in [`plugin/skills/orchestrate/SKILL.md`](../plugin/skills/orchestrate/SKILL.md).

## Models and effort

- **Coordinator:** whatever your session runs. The plugin doesn't change it; Opus is the intended choice.
- **Implementer:** Sonnet, high effort. Anthropic's [guidance for Sonnet 5.5](https://platform.claude.com/docs/en/models/sonnet-5-5/whats-new-sonnet-5-5) is medium for well-specified agentic coding and high for harder or longer tasks. The plugin has a single worker tier that also takes the harder well-specified slices, so it starts at high. The evals are there to test that choice.
- **No max effort** for the worker: Anthropic's effort guidance tops out at high for harder agentic coding, and max spends the most tokens.
- **One main model per session.** Sonnet 5.5 can't read Opus 5.5's thinking blocks, so switching the main model mid-session drops the reasoning so far. Start a new session instead.
- **For single-session work without subagents**, the [advisor](https://code.claude.com/docs/en/advisor.md) is the lighter option: `claude --model sonnet --advisor opus` lets Sonnet work and consult Opus at decision points.

## Other hosts

Split Orchestrator is a Claude Code plugin, so it runs wherever Claude Code runs. Two hosts have their own way to run work in parallel, and the plugin has notes for both:

| Host | What you get | Support |
|---|---|---|
| Claude Code (terminal, IDE, desktop) | Everything above | Supported, covered by the evals |
| [bb](../hosts/bb/README.md) | The plugin inside bb threads, plus optional rules for running slices as bb child threads with their own worktree | Supported; the child-thread rules aren't covered by the evals |
| [herdr](../hosts/herdr/README.md) | The plugin in herdr panes, plus `split-lead` and `split-worker` profiles for herdr-projects | Experimental |

## Optional review & browser checks

The README's second example adds Astra review through [Farcall](https://github.com/regenrek/farcall-mcp) & real browser checks through Claude in Chrome. Neither is bundled with Split Orchestrator or needed for the first example.

Install Farcall's `codex-worker`, sign in to the Codex CLI & follow its [host setup guide](https://github.com/regenrek/farcall-mcp/blob/main/docs/installation.md). Start the parent with automatic MCP backgrounding disabled so it can wait for the review without polling.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 claude --model opus --chrome
```

Connect the Claude in Chrome extension before the run. If multiple browsers are connected, identify the target browser in the prompt. Use a model ID your Codex CLI supports; the example requests `gpt-6-astra` at high effort, with read-only access.

Both examples require plan approval before implementation & approval before push, publish or deployment. These are explicit instructions for those runs. By default, the orchestration skill shares its plan & continues unless you ask to approve it first.

Three reviewer calls are a budget, not a guarantee of completion. If the final review leads to more fixes, report any unreviewed changes as remaining work.
