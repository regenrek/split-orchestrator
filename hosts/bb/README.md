# Split Orchestrator in bb

Install Split Orchestrator & Farcall's Codex worker on the machine running Claude Code, as in the [main README](../../README.md). Start a new Claude Code thread with `claude-opus-5-5`, high, and the [parent wait settings](../../docs/usage.md#setup). For UI tasks, verify browser control in the actual Sol QA session; a parent connection is not inherited.

Workers run through Farcall from that coordinator. They are not bb child threads. Do not install extra model-routing rules or use `bb thread spawn` as an implementation fallback.

## Coordinator continuity

Optional host guidance: prefer compaction in the existing coordinator thread only after verifying that the installed provider preserves its identity, child ownership and delivery. Keep a checkpoint and reconcile task/delegation/result records afterward. Do not compact while a direct Farcall wait is pending.

Re-parenting host-managed children is unsupported by this workflow for now: authorization/ancestry checks across transfer have not been verified. Same-root placement or a changed sidebar tree does not establish permissions, completion delivery or recovery. Any future supported transfer must cover descendants and queued/late notices as well as newly completed direct children.

Before replacing a coordinator, stop dispatch, finish direct waits and session-bound children, persist results and reconcile outstanding records. If this cannot be done safely, continue in place where supported, or leave the checkpoint and report the limitation. No new threads or re-parenting commands are prescribed here. See the [host-independent contract](../../plugin/skills/orchestrate/references/coordination.md).

## Remove the old 0.1 child-thread rules

If you previously used this repository's optional installer, its global instruction block can still redirect work to the retired native-worker setup. The helper now only removes that marked block, preserving other instructions. Preview first; `--apply` writes the change.

```sh
hosts/bb/install.sh
hosts/bb/install.sh --apply
```

It does not install new global instructions. Start a new coordinator session after cleanup. The plugin hook & skill are the workflow source.

The local checks exercise cleanup against a fake bb CLI. Actual Farcall waiting, model settings & browser access must be checked in the intended host session; local packaging checks do not prove them.
