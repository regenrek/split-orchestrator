# Split Orchestrator in bb

[bb](https://getbb.app) runs Claude Code threads, so the plugin works there on two levels:

| Level | What it adds | Setup |
|---|---|---|
| **Subagents** | The coordinator delegates to `split-orchestrator:implementer` inside one thread, as in a terminal | Install the plugin (see the [main README](../../README.md)) |
| **Child threads** (optional) | Slices that deserve their own branch or PR run as bb child threads with their own worktree, visible and steerable in the sidebar | Add [`instructions.md`](instructions.md) to bb's custom instructions |

## Subagents

Install the plugin at user scope on each machine that runs your bb threads:

```bash
claude plugin marketplace add regenrek/split-orchestrator
claude plugin install split-orchestrator@split-orchestrator
```

Then start a **new** Claude Code thread and ask: *"Which subagent types can you launch?"* The answer should include `split-orchestrator:implementer`. Existing threads load plugins only when their session starts.

## Child threads

bb decides a child thread's model from the spawn flags, and without them the child inherits the parent's model. [`instructions.md`](instructions.md) makes the coordinator pass Sonnet and high effort explicitly, and tells it when a child thread is worth more than a subagent.

bb's `instructions set` replaces the whole text, so use the script, which keeps whatever else is there:

```bash
hosts/bb/install.sh            # dry run: print the result
hosts/bb/install.sh --apply    # write it
hosts/bb/install.sh --remove --apply
```

The instructions apply to every agent on the bb host, from each thread's next session start. Custom instructions are limited to 4,096 characters; the block uses about 1,200.

## Status

Subagents in bb follow from plugin loading and need the one check above. The child-thread instructions follow bb's documented `thread spawn` flags; they haven't been measured with evals, because the eval harness runs plain Claude Code only.
