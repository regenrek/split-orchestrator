# Usage

[Back to the README](../README.md)

## Roles

| Role | Model | Effort | Responsibility |
|---|---|---|---|
| Coordinator/reviewer | `claude-opus-5-5` | `high` | Scope, contracts, ownership, integrated review & final acceptance |
| Implementation/integration | `gpt-6.1-sol` | `high` | Implementation, local checks, corrections & one exclusive integration owner |
| Routine checks (small-context subagent) | `claude-haiku-5-5` | `low` | Status, logs, HTTP/file links & content, bounded waits; no browser, GUI, Electron or product changes |
| Browser/Electron smoke (separate sessions) | `gpt-6.1-sol` | `medium` | Fixed checklists, real browser/Electron access, screenshots & viewport/layout checks through Farcall |
| Live QA (fresh session) | `gpt-6.1-sol` | `high` | Real browser/Electron or entry-point checks, persisted outcomes & rechecks; no product fixes |

Farcall is the required transport for Sol. Haiku uses the bundled native `split-orchestrator:routine-checker` subagent with a standalone brief, not a full-history fork. It is not a substitute implementer. A single Sol worker can implement & integrate; add implementers only for independent deliverables. Fresh Sol acceptance QA remains required for UI/Electron and substantial multi-worker work. Browser smoke, Electron tests and acceptance QA each have their own Sol Farcall session, separate from implementation. Medium is allowed only for fixed-checklist smoke; implementation, integration and acceptance QA require high. Haiku only handles checks without a browser or GUI. Opus reviews the integrated diff and actual evidence, assigning gaps and critical live rechecks to Sol QA. The coordinator does not click through the browser. A fresh reviewer is optional, with an agreed model and transport.

These are workflow instructions, not runtime enforcement of model selection or file access. The thread starter sets coordinator effort to `high`; the plugin cannot change it. The coordinator reports deviations and stops dispatch. Verify actual worker execution metadata against the assigned role and effort; for Haiku, inspect the matching Claude transcript's model and execution settings for effort. Definitions and requested values alone are not proof. Missing evidence stays unverified; no aliases or silent substitutions.

## Keep context small

Keep worker and child-agent chat reports within 15 lines, linking detailed files. Write long briefs/messages once to a file and pass its path; use Farcall `prompt_file` for long worker tasks. Read targeted ranges and filtered search results, while still reading required instructions.

Delegate status collection, log inspection and routine waits to Haiku with explicit checkpoints, a deadline and evidence paths. Use one bounded script or blocking wait, not repeated coordinator steps. Farcall calls still wait directly; neither agent polls pending workers.

Sol UI smoke checks include a named viewport and no unintended element extending beyond it or horizontal overflow. Document intended scroll regions; screenshots alone do not prove the assertion. Both smoke and routine checkers record expected/actual outcomes, failed assertions and missing access. They write evidence only and never fix product code. Green smoke does not constitute acceptance; Sol-high owns acceptance QA. Spot-check the first medium smoke runs with a separate high acceptance session on the same cases, revision, runtime and data. If medium finds substantially fewer issues, return smoke to high and record why. This initial comparison does not require duplicate full checks on every run.

Keep authoritative task state in repository/planning files and follow [coordinator continuity](coordinator-context.md): 150k handoff warning, fresh coordinator near 200k or at milestone/daily boundaries, exactly one dispatch owner, and 3–5 active streams. These are starting values. Results go to files; routine wakeups are batched. Optional compaction/cache settings are recommendations only; the plugin does not edit user configuration.

## Setup

Install Split Orchestrator & Farcall's `codex-worker` as shown in the README. Use Farcall with `run` & `run_batch` support; the reviewed reference is 0.1.7. Follow its [installation guide](https://github.com/regenrek/farcall-mcp/blob/main/docs/installation.md). Node 24+, a signed-in Codex CLI & access to the requested model are required.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 \
  claude --model claude-opus-5-5 --effort high
```

Set the environment before launching the parent. The plugin cannot retrofit completion waiting into an already running session. An interrupted call must be reconciled before retrying; never launch duplicate work or replace the wait with model-driven polling.

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
Report coordinator review findings, evidence and unresolved criteria.
No push, main merge, deployment or publishing without approval.
```

The full [orchestration skill](../plugin/skills/orchestrate/SKILL.md) covers failure/retry/conflict behavior, shared ownership, the minimal end-to-end path & acceptance. The [Farcall reference](../plugin/skills/orchestrate/references/farcall.md) covers call arguments, permissions, settings evidence, batch waiting & exact-session corrections.

## Update

```sh
claude plugin marketplace update split-orchestrator
claude plugin update split-orchestrator@split-orchestrator
```

Start a new Claude session after updating. Version 0.3.3 adds bounded coordinator sessions, durable handoffs and batched notifications. Version 0.3.2 routes all browser/Electron checks to Sol and limits Haiku to non-GUI checks. Version 0.3.1 introduced concise context/file handoffs. Version 0.3 adds separate Sol QA, concrete stateful acceptance cases and evidence tied to the final integrated commit. See the [acceptance contract](../plugin/skills/orchestrate/references/acceptance.md).

## Upgrade from 0.1

Version 0.2 replaces the Sonnet-subagent workflow. Update both marketplace plugins & start a new session; an existing session retains old instructions.

If you installed the old optional bb custom-instruction block, remove it with the [bb cleanup helper](../hosts/bb/README.md). Remove old herdr `split-worker` profile/default entries you added for this plugin; the [herdr notes](../hosts/herdr/README.md) describe the new setup. This repository does not edit your host or user configuration automatically.
