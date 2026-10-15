# Evidence & verification

[Back to the README](../README.md)

## Why the workflow changed

Practical workflow experiments informed this change. They compare complete runs, not isolated model capability. Task decomposition, worker count, effort, review & environments varied.

- **N, Opus → Sonnet.** Review caught one draft-loss case; later checks still found duplicate saves & drafts disappearing after a failed filter request.
- **O, Opus → Sol through Farcall.** Original-session corrections worked, but the worker ran at medium after failed starts. Later checks found lost drafts & duplicate saves. This is not evidence for an exact high/high configuration.
- **S, Opus high → five Sol high workers.** A blocking Farcall batch, a designated integrator & original-session corrections were exercised. Shared Core files still had competing edits; failed refreshes lost drafts & changed retries could return success without saving the changes.
- **X, Opus → two Sol workers.** At xhigh, with a separate Sol review, the evaluated result passed 23 backend cases & three input-recovery cases. A concurrent-edit/refresh path still hid unsaved work.

The practical collaboration-app run also exercised Farcall batches, integration handoffs & original-session corrections. It used xhigh workers and separate Astra reviews. The earlier finance release likewise included Astra, and later added project-specific model routing. Neither is proof of the exact 0.2 high/high workflow without Astra.

Version 0.2 adopted the requested Opus/Sol split with explicit shared ownership, one integration owner, an early real end-to-end path & coordinator acceptance of persisted outcomes. Version 0.3 adds a fresh Sol QA session for live testing, concrete stateful scenarios & evidence bound to the final integrated revision. Opus owns acceptance and assigns live rechecks to Sol when evidence or risk requires it. There is no general quality ranking or verified cost-saving claim for this split.

## Local checks

`scripts/check.sh` checks packaging, local links, the actual session-hook output & safe removal of old bb instructions. It does not invoke a model, launch a worker or establish application acceptance.

## Live acceptance scenarios

Run these in disposable checkouts with the configured parent & Farcall. Keep the actual model/effort, checkout/base, session/delegation IDs, result & check evidence. These are scenarios for validation, not additional mandatory suites for every user task.

| Scenario | Observable acceptance |
|---|---|
| Missing Farcall or wrong model/effort | Coordinator reports the blocker before implementation; no native worker, fallback model or direct CLI substitute |
| One small CLI feature | One isolated Sol worker implements & integrates; Sol QA exercises the actual command and reloads persisted state; Opus reviews the evidence |
| Browser/Electron smoke | Each has its own Sol-medium Farcall session with verified tool access, explicit checkpoints and viewport/overflow assertions; no Haiku or coordinator GUI fallback |
| Non-GUI routine check | Haiku low checks status, logs or HTTP/file links and content; GUI requests return to the coordinator for Sol |
| Two independent deliverables with a shared interface | One owner delivers the shared interface and minimal working path first; later batch uses disjoint checkouts; only the assigned integrator merges |
| Correction after integrated review | Exact original worker session resumes, the integrator incorporates the fix, the original QA session rechecks affected paths and core journeys on the new integrated commit |
| UI read/write failure & delayed response | Fresh Sol QA uses a real backend/browser; newer input survives failed refresh and delayed save responses, and reload proves what was stored |
| Retry or concurrent status change | Changed retries never acknowledge unapplied changes; a second session's status change cannot hide the first session's local draft |
| Missing QA browser/Electron access | Checks stay open; an authorized alternative is agreed explicitly, with no silent tool or permission substitution |
| Verification failure or unknown worker outcome | Failed assertion results in failed verification; unavailable evidence stays open; no duplicate dispatch or unauthorized push |
| Initial smoke-effort comparison | Sample early medium smoke runs against separate high acceptance QA on the same cases/revision/data; return smoke to high if medium finds substantially fewer issues, recording the decision |

## 0.3.12 verification scope

From the first 0.3.11 pilot day in three projects. Worked: rounds stayed at one or two per deliverable; reviewer-run tests and a combined Opus and Astra UI review found real defects before merge. Cost: QA still waited for review and recheck; one coordinator stated expected finishes without arranging a wake and missed a completion by 73 minutes; a QA brief with an unsourced expectation produced a false failure; a crashing check reported success; an integrator's hand-kept test list missed a suite and two reds reached the main branch; a coordinator re-asked a decided question. Instruction changes only; local packaging, link and hook checks pass. Not yet measured.

## 0.3.11 verification scope

From the 0.3.10 pilot in three projects (finance, team plugin rollout, game). Worked: the two-round limit turned a stalled test series into one decision; one decision ledger let the owner answer eight questions in one message; owner self-fixes of harness and environment failures; an early live run found seven real defects in about three hours that earlier reviews had missed. Cost: finished reviews sat unread 35 to 55 minutes because completion notices were lost; a start reported as aborted existed and caused a duplicate review; test-contract drift counted as correction rounds; long acceptance runs blocked the integration path on shared VM slots; a QA brief with exact error codes failed correct product behaviour. Instruction changes only; local packaging, link and hook checks pass. Not yet measured.

## 0.3.10 verification scope

From a coordinator retrospective of a three-day rollout: time went into heavy test machinery for small changes (three VM starts for one test and one doc file, each failing on the harness, about 2.5 hours) and target blockers found at the end instead of day one; a strong reviewer was most useful on the design before build, and static review passed checks that then failed in the VM. Replaces the 0.3.9 post-build Astra final review. Instruction changes only; local packaging, link and hook checks pass. Not yet measured.

## 0.3.9 verification scope

Derived from run records with overlapping reviews: in `cli-mcp` S01 seven Opus and five Fable passes repeatedly reported the same findings; in S05 Fable's final pass after Opus found no new blocker. No same-revision Astra/Opus comparison exists. Instruction changes only; local packaging, link and hook checks pass. Each stream now records class, review passes, correction rounds and defects first found by QA or live runs; drop the Astra final review if pilots show it finds no blockers.

## 0.3.8 verification scope

Derived from a blind four-analysis comparison of five real coordinator threads (rounds mostly from harness/evidence gaps, stacked reviewers, coordinator relay traffic). Instruction changes only. Local packaging, link and hook checks pass, including the new explicit-role hook case. Fewer rounds, faster delivery and unchanged defect detection are not yet measured; pilot on a real stream and compare rounds per deliverable, harness-vs-product reds, reviewer sessions, time to acceptance and reopened defects.

## 0.3.6 verification scope

This consolidates instruction ownership, risk tiers and host discovery. Packaging, document and bounded instruction-review checks do not prove live execution on every provider, context savings or review quality. Git-write access must be verified for the actual sandbox and metadata layout; the historical 0.3 smoke below is not a universal permission guarantee. No new live sandbox/browser workflow is claimed for this change.

## 0.3.4 verification scope

Separate full-diff review and targeted coordinator acceptance are instruction changes, with explicit reviewer selection and revision-bound findings. Packaging/link/hook checks do not prove review quality or reduced context usage. No live reviewer/QA workflow or context comparison has been measured for this release.

## 0.3.3 verification scope

The continuity instructions and documentation pass local packaging/link/hook checks. Live compaction, child delivery/transfer, batching and context savings have not been exercised. Same-session compaction and coordinator replacement have separate capability and reconciliation requirements. No fixed token or daily replacement thresholds apply; stream counts and batch intervals are adjustable guidance. User configuration is unchanged.

## 0.3.2 verification scope

This historical effort policy is superseded by the current [role/tier reference](../plugin/skills/orchestrate/references/review.md). Version 0.3.2 assigns all browser/Electron checks to Sol and limits Haiku to non-GUI work. Only fixed-checklist smoke uses medium; implementation, integration and acceptance QA stay high. The initial medium/high comparison is required for early real smoke runs but has not yet been performed here. Local packaging, hook and document checks pass. No new browser/Electron or model run was performed for this instruction update; the historical smoke records below do not establish GUI access or behavior for 0.3.2.

## 0.3.1 routine-check smoke

The local native Haiku checker passed a three-point documentation smoke with `claude-haiku-5-5` and low effort confirmed in its child transcript. See the [smoke record and limits](smoke-v0.3.1.md). Browser/layout behavior and token savings were not measured.

## 0.3 release smoke

On 2026-10-03, the installed 0.3 candidate completed a small live CLI task through Opus high → Sol high implementation/integration → fresh Sol high QA → Opus coordinator review. A reused operation ID with changed content was rejected without altering persisted data. Identical retries & new IDs worked. The worker's regression test passed, and QA exercised the actual CLI from a separate clean clone.

The worker initially could not commit because its clone's `.git` was read-only in the sandbox. Resuming the same session with that authorized directory as an explicit writable root resolved it. The Farcall reference now specifies this setup. No product correction was needed.

See the [smoke record](smoke-v0.3.md) for settings, outcomes & evidence limits. This validates a narrow CLI path, fresh QA separation & a worker permission-recovery resume. Browser/Electron access, UI race scenarios, parallel integration and product-fix QA rechecks were not exercised. No comparative quality or cost measurement was made.

## Historical results

[The 0.1.x eval results](evaluation-v0.1.md) cover native Sonnet subagents. The original suite is preserved at [tag v0.1.1](https://github.com/regenrek/split-orchestrator/tree/v0.1.1/plugin/evals). It cannot validate Farcall batching, exact-session correction or the new model roles.
