# Usage

[Back to the README](../README.md)

## Roles

The [role and review-tier reference](../plugin/skills/orchestrate/references/review.md) owns exact models, effort and review depth. Opus coordinates and accepts, Sol builds and verifies through Farcall, and Haiku handles non-GUI routine checks. Use the fewest workers: one may implement and integrate. Review depth follows the effect of the change; a trivial edit does not need the same chain as a migration.

These are workflow instructions, not runtime enforcement. Explicit reviewer choices remain supported. Missing execution metadata is unknown, a confirmed mismatch stops dispatch, and unknown worker outcomes require Farcall recovery. [Ownership and precedence](../plugin/skills/orchestrate/references/ownership.md) keep host/project skills from creating a second workflow.

## Keep context small

Keep worker/reviewer chat reports within 15 lines: exact commit, outcome, test evidence, blockers, risks/decisions and artifact path. Full logs/traces remain in worker artifacts. Do not routinely reread the complete diff or every artifact after separate review; unresolved evidence requires targeted follow-up, never blind acceptance. Summaries still accumulate in parent context. Write long briefs/messages once to a file and pass its path; use Farcall `prompt_file` for long worker tasks. Read targeted ranges and filtered search results, while still reading required instructions.

Delegate status collection, log inspection and routine waits to Haiku with explicit checkpoints, a deadline and evidence paths. Use one bounded script or blocking wait, not repeated coordinator steps. Farcall calls still wait directly; neither agent polls pending workers.

Sol UI smoke checks include a named viewport and no unintended element extending beyond it or horizontal overflow. Document intended scroll regions; screenshots alone do not prove the assertion. Both smoke and routine checkers record expected/actual outcomes, failed assertions and missing access. They write evidence only and never fix product code. Green smoke does not constitute acceptance; Sol-high owns acceptance QA. Spot-check the first medium smoke runs with a separate high acceptance session on the same cases, revision, runtime and data. If medium finds substantially fewer issues, return smoke to high and record why. This initial comparison does not require duplicate full checks on every run.

Keep authoritative task state in repository/planning files. [Coordinator continuity](coordinator-context.md) prefers same-session compaction with verified identity, child ownership and result delivery, followed by checkpoint reconciliation. Replacement is a separate guarded operation; no fixed token thresholds or daily replacement. Stream counts and routine notification batches are adjustable guidance. Optional compaction/cache settings are documented for the user; the coordinator does not execute `/autocompact` or edit configuration.

## Setup

Install Split Orchestrator & Farcall's `codex-worker` as shown in the README. Use Farcall with `run` & `run_batch` support; check the installed adapter version and its contract. Follow its [installation guide](https://github.com/regenrek/farcall-mcp/blob/main/docs/installation.md). Node 24+, a signed-in Codex CLI & access to the requested model are required.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 \
  claude --model claude-opus-5-5 --effort high
```

Coordinator rules load at session start only when the project has a run record `artifacts/<run-id>/run.md` or `SPLIT_ORCHESTRATOR_ROLE=coordinator` is set. Set the environment before launching the parent. The plugin cannot retrofit completion waiting into an already running session. An interrupted call must be reconciled before retrying; never launch duplicate work or replace the wait with model-driven polling.

For Claude in Chrome, add `--chrome` & connect the extension before the run. Other configured browser tools can be used if they can drive the real application/backend. Check the target device, URL, ports & test data first. Sol browser smoke, Electron testing and acceptance QA need actual tools in their separate sessions; do not assume access from the parent connection. Verify access in each assigned session. Missing access leaves checks open; agree an alternative with the user instead of silently changing tools or permissions. QA needs an isolated checkout and runtime state, with reproducible start/reset commands and test data.

Each implementer gets its own local clone with installed dependencies (plan several GB per worker); at close, the run removes what it created under the cleanup rules and keeps evidence & resume records.

Keep `artifacts/` ignored.

## Task prompt

Use `/split-orchestrator:orchestrate` followed by the task & constraints. Plan approval is explicit in the short README prompt. The skill respects existing approval rather than asking again.

```text
/split-orchestrator:orchestrate Build <feature> in <repository>.
Constraints: <scope, product behavior and environment restrictions>.
Propose a short plan with observable acceptance criteria and wait for approval.
Use the fewest workers needed, with isolated checkouts and explicit ownership.
Give one Sol worker integration responsibility.
For UI or substantial multi-worker work, have fresh Sol QA verify the integrated result and persisted state.
Report separate-review findings, coordinator acceptance, evidence and unresolved criteria.
No push, main merge, deployment or publishing without approval.
```

The full [orchestration skill](../plugin/skills/orchestrate/SKILL.md) covers failure/retry/conflict behavior, shared ownership, the minimal end-to-end path & acceptance. The [Farcall reference](../plugin/skills/orchestrate/references/farcall.md) covers call arguments, permissions, settings evidence, batch waiting & exact-session corrections.

## Update

```sh
claude plugin marketplace update split-orchestrator
claude plugin update split-orchestrator@split-orchestrator
```

New sessions load the updated plugin. Running coordinators need the explicit updated reviewer choice and [review contract](../plugin/skills/orchestrate/references/review.md) supplied as a bounded instruction before their next review; installation alone does not prove they applied it. Do not restart or replace them just for this update. Version 0.3.4 moves full-diff review to its own session and keeps coordinator acceptance targeted. Version 0.3.3 adds host-aware continuity, durable checkpoints and batched notifications. Version 0.3.2 routes all browser/Electron checks to Sol and limits Haiku to non-GUI checks. Version 0.3.1 introduced concise context/file handoffs. Version 0.3 adds separate Sol QA, concrete stateful acceptance cases and evidence tied to the final integrated commit. See the [acceptance contract](../plugin/skills/orchestrate/references/acceptance.md).

## Upgrade from 0.1

Version 0.2 replaces the Sonnet-subagent workflow. Update both marketplace plugins & start a new session; an existing session retains old instructions.

If you installed the old optional bb custom-instruction block, remove it with the [bb cleanup helper](../hosts/bb/README.md). Remove old herdr `split-worker` profile/default entries you added for this plugin; the [herdr notes](../hosts/herdr/README.md) describe the new setup. This repository does not edit your host or user configuration automatically.
