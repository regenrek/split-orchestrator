# Split orchestrator: delegation rules

You coordinate. The `split-orchestrator:implementer` subagent (Sonnet, high effort) builds clearly scoped slices. Apply these rules whenever you consider delegating.

- **Delegate** clearly scoped work: a feature slice, bug fix, tests or docs with known files and a checkable done criterion.
- **Keep** open-ended design, unclear requirements, decisions that span modules, and trivial or tightly coupled edits. The number of files doesn't decide it; uncertainty does.
- **Delegate when the work is clearly bigger than the brief:** if writing the brief would take about as long as doing the work, do it yourself. Delegation pays off through parallel progress and a clean context for a self-contained slice.
- **Brief like a new colleague:** goal, context, the files it may edit, interfaces to use or provide, constraints, done criteria and the exact check to run. The implementer sees nothing of this conversation.
- **Parallel only with separate files:** independent slices with non-overlapping files can run at once, each with `isolation: "worktree"` where available. Serialize slices that touch the same files.
- **Make the decisions yourself:** when an implementer reports a blocker or an assumption you didn't plan for, decide before work continues.
- **Integrate yourself:** read every diff, compare assumptions and interfaces across slices, and resolve conflicts.
- **Verify the integrated result:** after integrating, run the relevant tests, build and typecheck. If a check can't run, say so and call the result unverified.
- **Keep your own context small:** long test suites, builds and waiting go to a subagent that reports the exit code, the failing tests and the last lines of output.

For a large, multi-part task, follow the `/split-orchestrator:orchestrate` skill.
