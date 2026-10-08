# 0.3.1 routine-check smoke

On 2026-10-08, a local-plugin Opus-high session invoked the native `split-orchestrator:routine-checker` once, without a model override, and waited for completion. The child checked the documented role split and direct Farcall wait rule. All three checkpoints passed.

The matching child transcript recorded `message.model: claude-haiku-5-5`, `effort: low` and `perTurnEffort: low`. Agent metadata identified the configured routine checker at spawn depth 1 with a foreground request. These are execution records, not a model's self-description.

The child used one targeted search and one bounded file read. Its final report was 9 lines, with expected/actual outcomes and limits. No product files changed. This narrow smoke used a short inline brief and returned its evidence in the saved transcript; linked-file handoffs were not exercised.

Both plugin manifests, shell checks, local document links, the session hook and legacy cleanup checks passed (`scripts/check.sh`, 8 tests).

This proves local agent discovery, the exact Haiku model/effort and a bounded documentation check. It does not verify browser/Electron access, layout assertions, long-running status collection, Sol acceptance QA or comparative token savings. Those remain separate checks against the actual application and configured tools.
