# Historical evaluation of 0.1.x

[Current verification](evaluation.md)

These results cover the retired Sonnet-subagent workflow. They do not validate the 0.2 Farcall workflow.

## Results

Measured on 2026-09-29 with Claude Code 2.1.284 and Opus 5.5 as the coordinator: 4 cases, 3 runs each with and without the plugin, 24 runs in total for $6.15 at list price. Every run passed its outcome graders, with and without the plugin. These check limited outcomes, like stubs being replaced and the test suite passing, so they don't show a quality difference either way. The delegation indicators, which aren't scored, show that the coordinator never delegated on its own.

| Case | Delegated with the plugin | Cost with | Cost without | Time with | Time without |
|---|---|---|---|---|---|
| `trivial-edit-stays-local` | never | $0.10 | $0.09 | 8 s | 7 s |
| `small-slices` | never | $0.20 | $0.17 | 29 s | 26 s |
| `larger-modules` | never | $0.27 | $0.23 | 47 s | 39 s |
| `requested-delegation` | every run | $0.45 | $0.55 | 47 s | 55 s |

- **Delegated work costs less.** Asked for one subagent per module, the coordinator handed the modules to Sonnet implementers. That was 18% cheaper and 15% faster than the same delegation without the plugin, where the subagents run on Opus. This mostly reflects the price difference between the models.
- **Opus 5.5 keeps small and mid-size work.** It didn't delegate three independent 20–40 line modules on its own in any run, and doing them directly was cheaper than any run that delegated. To get delegation, use `/split-orchestrator:orchestrate` or ask for it.
- **Otherwise the overhead is small.** The rules add about 500 input tokens per session, roughly a cent on Opus. The bigger gaps in the middle rows are most likely run-to-run variance: some runs in both arms spent extra turns fixing a failing test, and a repeat of `small-slices` cost $0.151 with the plugin and $0.149 without.

Three runs per case is a small sample, and these tasks are much smaller than the large, multi-part work the plugin is built for. Read the numbers as a sanity check, not a benchmark.

## Run the evals

The suite in [`plugin/evals`](https://github.com/regenrek/split-orchestrator/tree/v0.1.1/plugin/evals) uses Claude Code's built-in [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals.md). Each case runs with the plugin and again without it, so the difference shows what the plugin adds.

| Case | What it checks |
|---|---|
| `trivial-edit-stays-local` | A two-line rename is done directly, with no subagent |
| `small-slices` | Three small functions: the plugin doesn't make the result worse |
| `larger-modules` | Three independent modules: result, and whether the coordinator delegates on its own |
| `requested-delegation` | One subagent per module on request: Sonnet implementers against general-purpose subagents on the main model |

Check out tag `v0.1.1` in a separate directory to reproduce the old suite.

```bash
cd plugin
claude plugin eval . --trust-plugin --scaffold \
  --allow-tools Write Edit "Bash(python3 *)" "Bash(git *)"
```

`--scaffold` runs each case's setup script, which creates a small Python project in the run's temporary workspace. The full suite makes 24 runs on Opus and costs a few dollars at list price; add `--case <name> --runs 1` to try one case.
