# Usage

[Back to the README](../README.md)

## Roles

| Role | Model | Effort | Responsibility |
|---|---|---|---|
| Coordinator/reviewer | `claude-opus-5-5` | `high` | Scope, contracts, ownership, integrated review & final acceptance |
| Implementation/integration | `gpt-6.1-sol` | `high` | Implementation, local checks, corrections & one exclusive integration owner |
| Live QA (fresh session) | `gpt-6.1-sol` | `high` | Real browser/Electron or entry-point checks, persisted outcomes & rechecks; no product fixes |

Farcall is the required transport. There is no native implementer agent, alternate host worker route or Astra review step. A single Sol worker can implement & integrate. Add implementers only for independent deliverables. Use separate QA for UI/Electron and substantial multi-worker work; small tasks can be checked directly by Opus. Opus evaluates actual evidence without routinely replaying QA clicks. Evidence gaps, contradictions, marked risks or a user request trigger its own live checks. A fresh reviewer is optional, with an agreed model and transport.

These are workflow instructions, not runtime enforcement of model selection or file access. The plugin cannot change the coordinator's model or effort. Start it with the exact settings & check actual worker execution metadata. Missing evidence stays unverified; a mismatch blocks further dispatch. No silent substitutions.

## Setup

Install Split Orchestrator & Farcall's `codex-worker` as shown in the README. Use Farcall with `run` & `run_batch` support; the reviewed reference is 0.1.7. Follow its [installation guide](https://github.com/regenrek/farcall-mcp/blob/main/docs/installation.md). Node 24+, a signed-in Codex CLI & access to the requested model are required.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 \
  claude --model claude-opus-5-5 --effort high
```

Set the environment before launching the parent. The plugin cannot retrofit completion waiting into an already running session. An interrupted call must be reconciled before retrying; never launch duplicate work or replace the wait with model-driven polling.

For Claude in Chrome, add `--chrome` & connect the extension before the run. Other configured browser tools can be used if they can drive the real application/backend. Check the target device, URL, ports & test data first. QA browser tools are separate and must not be assumed from the parent connection. Verify access in that exact session. Missing access leaves checks open; agree an alternative with the user instead of silently changing tools or permissions. QA needs an isolated checkout and runtime state, with reproducible start/reset commands and test data.

Each worker gets its own local clone with installed dependencies (plan several GB per worker); at close, the run removes what it created under the cleanup rules and keeps evidence & resume records.

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

Start a new Claude session after updating. Version 0.3 adds separate Sol QA, concrete stateful acceptance cases and evidence tied to the final integrated commit. See the [acceptance contract](../plugin/skills/orchestrate/references/acceptance.md).

## Upgrade from 0.1

Version 0.2 replaces the Sonnet-subagent workflow. Update both marketplace plugins & start a new session; an existing session retains old instructions.

If you installed the old optional bb custom-instruction block, remove it with the [bb cleanup helper](../hosts/bb/README.md). Remove old herdr `split-worker` profile/default entries you added for this plugin; the [herdr notes](../hosts/herdr/README.md) describe the new setup. This repository does not edit your host or user configuration automatically.
