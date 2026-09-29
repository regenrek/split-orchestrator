# Split Orchestrator

A Claude Code plugin that splits the work the way a good lead does: your main model plans, makes the decisions and checks the result, and a Sonnet implementer builds the clearly scoped slices.

- **Rules in every session.** A small set of delegation rules tells the coordinator what to hand off, what to keep, and how to brief, integrate and verify.
- **One worker, fixed model.** `split-orchestrator:implementer` always runs on Sonnet at high effort, however you start the session. It stays in scope, stops instead of guessing, and reports what it checked.
- **A skill for big tasks.** `/split-orchestrator:orchestrate` runs a large, multi-part task end to end: define done, split, dispatch in parallel where files don't overlap, integrate, verify.

It's deliberately conservative. Small tasks stay with the coordinator, because a good brief would be as long as the code. The [results](#results) show where that line falls.

## Install

In Claude Code:

```
/plugin marketplace add regenrek/split-orchestrator
/plugin install split-orchestrator@split-orchestrator
```

Or from your shell:

```bash
claude plugin marketplace add regenrek/split-orchestrator
claude plugin install split-orchestrator@split-orchestrator
```

Start a new session afterwards. The implementer uses Claude Code's `sonnet` alias, which resolves to Sonnet 5.5 in current versions. The plugin is tested with Claude Code 2.1.284.

## Use

Run your main session on Opus, then work as usual:

```bash
claude --model opus
```

- **Everyday work:** the coordinator hands clearly scoped work that's worth a brief to `split-orchestrator:implementer` and keeps small edits, design questions and anything unclear.
- **A large task:** `/split-orchestrator:orchestrate migrate the billing module to the new payments API`
- **Delegation on request:** ask for it ("give each module its own subagent"), or call the agent directly with `@agent-split-orchestrator:implementer`.

## How the coordinator decides

| Delegate to the implementer | Keep in the main session |
|---|---|
| A feature slice, bug fix, tests or docs with known files and a checkable done criterion | Open-ended design, unclear requirements, decisions that span modules |
| Work clearly bigger than the brief it needs | Edits where the brief would be as long as the work |
| Independent slices with separate files, in parallel | Slices that touch the same files (those run one after another) |

Every brief states the goal, context, the files the implementer may edit, the interfaces to use, constraints, done criteria and the exact check to run. When an implementer reports a blocker, the coordinator makes the decision. At the end, the coordinator reads every diff, compares the slices' assumptions and runs the checks on the integrated result, not just the per-slice ones.

The full rules are in [`plugin/rules/coordinator.md`](plugin/rules/coordinator.md), the implementer in [`plugin/agents/implementer.md`](plugin/agents/implementer.md), and the orchestration steps in [`plugin/skills/orchestrate/SKILL.md`](plugin/skills/orchestrate/SKILL.md).

## Models and effort

- **Coordinator:** whatever your session runs. The plugin doesn't change it; Opus is the intended choice.
- **Implementer:** Sonnet, high effort. Anthropic's [guidance for Sonnet 5.5](https://platform.claude.com/docs/en/models/sonnet-5-5/whats-new-sonnet-5-5) is medium for well-specified agentic coding and high for harder or longer tasks. The plugin has a single worker tier that also takes the harder well-specified slices, so it starts at high. The evals are there to test that choice.
- **No max effort** for the worker: Anthropic's effort guidance tops out at high for harder agentic coding, and max spends the most tokens.
- **One main model per session.** Sonnet 5.5 can't read Opus 5.5's thinking blocks, so switching the main model mid-session drops the reasoning so far. Start a new session instead.
- **For single-session work without subagents**, the [advisor](https://code.claude.com/docs/en/advisor.md) is the lighter option: `claude --model sonnet --advisor opus` lets Sonnet work and consult Opus at decision points.

## Results

Measured on 2026-09-29 with Claude Code 2.1.284 and Opus 5.5 as the coordinator: 4 cases, 3 runs each with and without the plugin, 24 runs in total for $6.15 at list price. Every run passed all of its graders, with and without the plugin.

| Case | Delegated with the plugin | Cost with | Cost without | Time with | Time without |
|---|---|---|---|---|---|
| `trivial-edit-stays-local` | never | $0.10 | $0.09 | 8 s | 7 s |
| `small-slices` | never | $0.20 | $0.17 | 29 s | 26 s |
| `larger-modules` | never | $0.27 | $0.23 | 47 s | 39 s |
| `requested-delegation` | every run | $0.45 | $0.55 | 47 s | 55 s |

- **Delegated work costs less at the same quality.** Asked for one subagent per module, the coordinator handed the modules to Sonnet implementers. That was 18% cheaper and 15% faster than the same delegation without the plugin, where the subagents run on Opus.
- **Opus 5.5 keeps small and mid-size work.** It didn't delegate three independent 20–40 line modules on its own in any run, and doing them directly was cheaper than any run that delegated.
- **Otherwise the overhead is small.** The rules add about 500 input tokens per session, roughly a cent on Opus. The bigger gaps in the middle rows are run-to-run variance: some runs in both arms spent extra turns fixing a failing test, and a repeat of `small-slices` cost $0.151 with the plugin and $0.149 without.

Three runs per case is a small sample, and these tasks are much smaller than the large, multi-part work the plugin is built for. Read the numbers as a sanity check, not a benchmark.

## Other hosts

Split Orchestrator is a Claude Code plugin, so it runs wherever Claude Code runs. Two hosts have their own way to run work in parallel, and the plugin has notes for both:

| Host | What you get | Support |
|---|---|---|
| Claude Code (terminal, IDE, desktop) | Everything above | Supported, covered by the evals |
| [bb](hosts/bb/README.md) | The plugin inside bb threads, plus optional rules for running slices as bb child threads with their own worktree | Supported; the child-thread rules aren't covered by the evals |
| [herdr](hosts/herdr/README.md) | The plugin in herdr panes, plus `split-lead` and `split-worker` profiles for herdr-projects | Experimental |

## Run the evals

The suite in [`plugin/evals`](plugin/evals) uses Claude Code's built-in [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals.md). Each case runs with the plugin and again without it, so the difference shows what the plugin adds.

| Case | What it checks |
|---|---|
| `trivial-edit-stays-local` | A two-line rename is done directly, with no subagent |
| `small-slices` | Three small functions: the plugin doesn't make the result worse |
| `larger-modules` | Three independent modules: result, and whether the coordinator delegates on its own |
| `requested-delegation` | One subagent per module on request: Sonnet implementers against general-purpose subagents on the main model |

```bash
cd plugin
claude plugin eval . --trust-plugin --scaffold \
  --allow-tools Write Edit "Bash(python3 *)" "Bash(git *)"
```

`--scaffold` runs each case's setup script, which creates a small Python project in the run's temporary workspace. The full suite makes 24 runs on Opus and costs a few dollars at list price; add `--case <name> --runs 1` to try one case.

## Development

- Try local changes with `claude --plugin-dir ./plugin`.
- [`scripts/check.sh`](scripts/check.sh) validates the plugin and marketplace, lints the shell scripts and makes sure the worker's model and effort (Sonnet, high effort) read the same everywhere. CI runs it on every push.

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

## License

[MIT](LICENSE)
