---
name: orchestrate
description: Coordinate a large, multi-part coding task. Plan it, split it into clearly scoped slices, delegate them to split-orchestrator:implementer subagents, then integrate and verify the result yourself. Use for features, migrations or refactors made of several independent pieces of work, or when the user asks to orchestrate, split up or delegate a task.
argument-hint: <task>
---

# Orchestrate

Run the task as its coordinator. You own the plan, every design decision, the integration and the final check. `split-orchestrator:implementer` subagents (Sonnet, high effort) build the clearly scoped slices.

## 1. Understand the task and define done

- Read enough of the code to plan: entry points, the modules involved, existing patterns.
- Find the project's checks: test, build, lint and typecheck commands (package.json, Makefile, pyproject.toml, CI config).
- Write down what done means for the whole task: the behaviour someone can observe, plus the checks that must pass.
- If an open question would change the design, ask the user now. Questions that only affect one slice can wait for that slice.

## 2. Split the work into slices

Give each slice a goal, the files it owns, the interfaces it uses or provides, a done criterion and a check. Then decide who builds it:

| Slice | Owner |
|---|---|
| Clearly scoped, known files, checkable | implementer |
| Needs a design decision, has unclear requirements or cuts across modules | you |
| A few lines, or tightly coupled to what you're doing | you |

Settle shared interfaces (types, function signatures, API shapes, file formats) before you dispatch anything. Either build them first or write them verbatim into every brief that depends on them.

Share the plan with the user in a few lines (slices, owners, what runs in parallel) and continue, unless they asked to approve plans first.

## 3. Dispatch

The implementer sees nothing of your conversation, so every brief has to stand on its own:

```
Goal: <what this slice delivers and why>
Context: <decisions already made, relevant background>
You may edit: <files or directories>
Read for context: <files>
Interfaces: <exact signatures, types or formats to use or provide>
Constraints: <no new dependencies, keep the public API, style rules, ...>
Done when: <observable criteria>
Check: <exact command(s) to run>
```

- **Parallel:** slices that share no files and don't need each other's output go out together, in one message. In a git repository, give each `isolation: "worktree"` and tell it in the brief to commit its work on the worktree branch, so you can merge it. If worktree isolation isn't available, run them in the shared tree and tell each implementer not to commit.
- **Sequential:** everything else runs one after another in the working tree.
- Never dispatch a slice that needs another slice's unfinished result.

## 4. Handle reports

- **done:** confirm that the reported check actually ran and passed before you build on it.
- **blocked, or an assumption you didn't plan for:** make the decision yourself. Then send a new brief with the decision and the previous report, or take the slice over.
- A slice that comes back blocked twice is yours.

## 5. Integrate

- Merge worktree branches one at a time and resolve conflicts yourself.
- Read every diff. Look for mismatched assumptions or interfaces between slices, duplicated helpers, and edits outside the agreed files.

## 6. Verify and report

- Run the full checks on the integrated result, not just the per-slice checks. Fix what fails, or report it.
- If the user wants independent verification and a tool for it is available, such as Proofloop, run it now.
- Report to the user: what each slice changed, the decisions you made, every check with its result, anything unverified, and suggested follow-ups.
