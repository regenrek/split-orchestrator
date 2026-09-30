# Split Orchestrator

![Split Orchestrator. One coordinator helps three coding mascots assemble their separate pieces.](docs/images/split-orchestrator-banner.png)

Let Opus plan & review while Sonnet builds the clearly scoped parts.

A Claude Code plugin for work that benefits from a few implementers. Your main session owns the decisions, integration & final checks. Each implementer gets clear file ownership & a checkable task, using Sonnet, high effort. Small edits stay in the main session.

## Install

In Claude Code, run

```text
/plugin marketplace add regenrek/split-orchestrator
/plugin install split-orchestrator@split-orchestrator
```

Start a new Opus session. The delegation rules load automatically. Use `/split-orchestrator:orchestrate` for a larger task.

![Example orchestration. Opus coordinates Sonnet implementers in separate worktrees, drives browser checks after integration & optionally consults Astra through Farcall for read-only review.](docs/images/orchestration-example.png)

## Try it

Replace `<feature>` & `<repository>` with your task.

```text
/split-orchestrator:orchestrate Build <feature> in <repository>.
Propose a short plan and wait for my approval.
Split the work, implement it and run relevant tests.
Report what changed, what passed and what remains open.
No push, publish or deployment without approval.
```

### With Farcall (optional)

For an independent review, add [Farcall](https://github.com/regenrek/farcall-mcp). This example also uses Claude in Chrome for browser checks. [Set up both integrations first](docs/usage.md#optional-review--browser-checks).

```text
/split-orchestrator:orchestrate Build <feature> in <repository>.
Read the existing code and propose a short plan with acceptance criteria.
Wait for my approval before starting implementers.
Give each implementer clear file ownership and its own worktree branch.
You own architecture, integration and final verification.

For difficult decisions, consult Astra through Farcall: codex-worker,
model gpt-6-astra, effort high, read-only. Maximum 3 calls: planning,
after two failed attempts, and final diff review. Request concrete
correctness risks, not style advice. You decide; Astra advises.
Wait for completion without polling.

Run relevant tests and real browser checks using Claude in Chrome.
Explicitly report checks you could not run.
No push, publish or deployment without approval.
Finish with: what changed, what passed, review findings and remaining work.
```

## A real use case

In one finance-app release run, Opus planned & integrated eight Sonnet slices in separate worktrees. All three Astra reviews found concrete issues. Real browser journeys caught three more bugs. The run reported 16 passing end-to-end tests.

Verification accounted for most coordinator token usage, & the last fixes still needed independent review. A useful run, with remaining work clearly reported.

## Docs

[Usage & models](docs/usage.md) · [Evals & results](docs/evaluation.md) · [Development](docs/development.md) · [bb](hosts/bb/README.md) · [herdr](hosts/herdr/README.md)

[MIT license](LICENSE)
