# Split Orchestrator in herdr

Use a Claude Code pane with Split Orchestrator & Farcall installed, following the [main README](../../README.md). Start the parent with `claude-opus-5-5`, high, and the completion-wait environment settings.

The coordinator dispatches Sol through Farcall. This version does not provide herdr-projects worker profiles or use panes as an alternate implementation transport.

If you added the old `split-lead` / `split-worker` profiles and defaults for 0.1, remove those entries from your herdr-projects settings or choose your usual defaults. Do not delete unrelated profiles. This repository does not edit your settings.

Host-specific waiting and browser behavior still need a live check in your setup.
