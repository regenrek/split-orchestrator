# Split Orchestrator

![Split Orchestrator. One coordinator helps three coding mascots assemble their separate pieces.](docs/images/split-orchestrator-banner.png)

Opus coordinates & reviews. Haiku handles checks without a GUI. Sol builds, integrates & runs browser/Electron tests and acceptance QA through [Farcall](https://github.com/regenrek/farcall-mcp).

A Claude Code plugin for clearly owned work, direct completion waits & checks against the real application. Use the fewest workers needed. One worker owns integration. A fresh Sol QA session tests the integrated app; Opus owns final acceptance.

[Roles, model/effort defaults & review tiers](plugin/skills/orchestrate/references/review.md) live in one place. Explicit reviewer choices, including Astra, are supported without silent substitutions. [Farcall owns transport; Split owns the workflow](plugin/skills/orchestrate/references/ownership.md). Project instructions add project facts, not another orchestration rulebook.

## Install

Install both plugins in Claude Code. Farcall is required.

```text
/plugin marketplace add regenrek/farcall-mcp
/plugin install codex-worker@farcall
/plugin marketplace add regenrek/split-orchestrator
/plugin install split-orchestrator@split-orchestrator
```

With Node 24+ & a signed-in Codex CLI available, start a new coordinator session from your repository.

```sh
CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0 MCP_TOOL_TIMEOUT=7200000 \
  claude --model claude-opus-5-5 --effort high
```

[Setup, browser access & upgrading from 0.1](docs/usage.md).

![Opus coordinates Sol workers through Farcall. One Sol worker integrates their commits. A fresh Sol QA session tests the integrated application. Opus reviews the evidence and owns acceptance.](docs/images/orchestration-example.png)

## Try it

```text
/split-orchestrator:orchestrate Build <feature> in <repository>.
Propose a short plan and wait for my approval.
Report what changed, what passed and what remains open.
No push, main merge, deployment or publishing without approval.
```

The skill handles ownership, isolated checkouts, worker corrections & coordinator acceptance. Add constraints or specific user journeys to the prompt. UI work requires a working browser connection in the QA session to the real application/backend.

Each implementer gets its own local clone with installed dependencies (plan several GB per worker); at close, the run removes what it created under the cleanup rules and keeps evidence & resume records.

Reports stay within 15 chat lines, with details in linked files. Small-context Haiku subagents check status, logs and HTTP/file content & handle routine waits. Sol runs browser smoke, Electron tests & acceptance QA in separate Farcall sessions; quick smoke uses a fixed checklist at medium. Spot-check early medium runs with high acceptance QA; return smoke to high if medium finds substantially fewer issues. The coordinator checks risks, findings & test evidence selectively after the separate full-diff review, deepening open issues without routinely importing the entire diff again. Summaries still accumulate; context is not constant. [Context & check roles](docs/usage.md#keep-context-small).

Prefer same-session compaction with a checkpoint in files and verified host continuity. Replace coordinators only after safe reconciliation or a verified host transfer. Start with 3–5 active streams & batched routine updates, adapting to workload. [Continuity, host notes & optional cache settings](docs/coordinator-context.md).

Optional: if your chosen workflow uses native Codex subagents, wait with explicit `collaboration.wait_agent(timeout_ms=1800000)`, without polling. This does not change the Farcall workflow above. [Native Codex waits & optional local setup](hosts/bb/README.md#optional-native-codex-waits).

## Why this workflow

In practical builds, Opus coordinated Sol workers through Farcall & returned corrections to their original sessions. The benchmarks also exposed shared-file conflicts, lost drafts & retries that reported success without saving changes. This workflow makes ownership & persisted outcomes explicit. It is not a claim that a model pairing guarantees quality.

[Evidence & verification limits](docs/evaluation.md).

## Docs

[Usage](docs/usage.md) · [Verification](docs/evaluation.md) · [Development](docs/development.md) · [bb](hosts/bb/README.md) · [herdr](hosts/herdr/README.md)

[MIT license](LICENSE)
