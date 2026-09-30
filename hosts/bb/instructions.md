## Split orchestrator in bb: child threads

- A slice that is its own branch or PR, runs long, or that the user may want to watch or steer goes to a bb child thread. Quick lookups and slices whose result you need right away stay `split-orchestrator:implementer` subagents.
- Spawn with an explicit model and effort, because a child without them inherits yours:
  `bb thread spawn --project "$BB_PROJECT_ID" --parent-self --new-environment worktree --model claude-sonnet-5-5 --reasoning-level high --title "<slice>" --prompt-file <brief.md>`
- The child is a full session, not a subagent. Start its brief with: "You build one slice for a coordinator thread. The split-orchestrator coordinator rules in your context don't apply to you, so don't delegate. Edit only the files listed. If a requirement is unclear, you need other files, or the same fix fails twice, stop and report instead of guessing. End with Status, Changes, Assumptions and Checks (the commands you ran and their results)."
- The split-orchestrator rules still apply: separate files per child, you decide blockers, you integrate and verify.
- You're notified when a child finishes. Read its result with `bb thread output <id>` and answer it with `bb thread tell <id> --message-file <file>`.
