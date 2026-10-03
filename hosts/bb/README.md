# Split Orchestrator in bb

Install Split Orchestrator & Farcall's Codex worker on the machine running Claude Code, as in the [main README](../../README.md). Start a new Claude Code thread with `claude-opus-5-5`, high, and the [parent wait settings](../../docs/usage.md#setup). For UI tasks, verify its browser connection.

Workers run through Farcall from that coordinator. They are not bb child threads. Do not install extra model-routing rules or use `bb thread spawn` as an implementation fallback.

## Remove the old 0.1 child-thread rules

If you previously used this repository's optional installer, its global instruction block can still redirect work to the retired native-worker setup. The helper now only removes that marked block, preserving other instructions. Preview first; `--apply` writes the change.

```sh
hosts/bb/install.sh
hosts/bb/install.sh --apply
```

It does not install new global instructions. Start a new coordinator session after cleanup. The plugin hook & skill are the workflow source.

The local checks exercise cleanup against a fake bb CLI. Actual Farcall waiting, model settings & browser access must be checked in the intended host session; local packaging checks do not prove them.
