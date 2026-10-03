# Evidence & verification

[Back to the README](../README.md)

## Why the workflow changed

The [workflow experiments](https://kevinkern.dev/benchmarks/marlies-workflows/) informed this change. They compare complete runs, not isolated model capability. Task decomposition, worker count, effort, review & environments varied.

- **N, Opus → Sonnet.** Review caught one draft-loss case; later checks still found duplicate saves & drafts disappearing after a failed filter request.
- **O, Opus → Sol through Farcall.** Original-session corrections worked, but the worker ran at medium after failed starts. Later checks found lost drafts & duplicate saves. This is not evidence for an exact high/high configuration.
- **S, Opus high → five Sol high workers.** A blocking Farcall batch, a designated integrator & original-session corrections were exercised. Shared Core files still had competing edits; failed refreshes lost drafts & changed retries could return success without saving the changes.
- **X, Opus → two Sol workers.** At xhigh, with a separate Sol review, the evaluated result passed 23 backend cases & three input-recovery cases. A concurrent-edit/refresh path still hid unsaved work.

The practical collaboration-app run also exercised Farcall batches, integration handoffs & original-session corrections. It used xhigh workers and separate Astra reviews. The earlier finance release likewise included Astra, and later added project-specific model routing. Neither is proof of the exact 0.2 high/high workflow without Astra.

Version 0.2 adopts the requested Opus/Sol split with explicit shared ownership, one integration owner, an early real end-to-end path & coordinator acceptance of persisted outcomes. There is no general quality ranking or verified cost-saving claim for this new version.

## Local checks

`scripts/check.sh` checks packaging, local links, the actual session-hook output & safe removal of old bb instructions. It does not invoke a model, launch a worker or establish application acceptance.

## Live acceptance scenarios

Run these in disposable checkouts with the configured parent & Farcall. Keep the actual model/effort, checkout/base, session/delegation IDs, result & check evidence. These are scenarios for validation, not additional mandatory suites for every user task.

| Scenario | Observable acceptance |
|---|---|
| Missing Farcall or wrong model/effort | Coordinator reports the blocker before implementation; no native worker, fallback model or direct CLI substitute |
| One small CLI feature | One isolated Sol worker implements & integrates; Opus exercises the actual command and reloads persisted state |
| Two independent deliverables with a shared interface | One owner delivers the shared interface and minimal working path first; later batch uses disjoint checkouts; only the assigned integrator merges |
| Correction after integrated review | Exact original worker session resumes, the integrator incorporates the fix, Opus rechecks affected paths without a duplicate full pass |
| UI read/write failure & delayed response | Real backend/browser interaction preserves unsaved input; reload proves what was stored; changed retries never acknowledge unapplied changes |
| Verification failure or unknown worker outcome | Failed assertion results in failed verification; unavailable evidence stays open; no duplicate dispatch or unauthorized push |

The 0.2 live acceptance scenarios have not yet been run. The older recorded workflows are supporting design evidence only.

## Historical results

[The 0.1.x eval results](evaluation-v0.1.md) cover native Sonnet subagents. The original suite is preserved at [tag v0.1.1](https://github.com/regenrek/split-orchestrator/tree/v0.1.1/plugin/evals). It cannot validate Farcall batching, exact-session correction or the new model roles.
