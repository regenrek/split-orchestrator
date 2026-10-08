# Farcall call contract

Use the installed Farcall Codex worker tools directly. Tool prefixes vary by host; resolve the actual `codex_worker` namespace. Farcall is a required, separately installed dependency. Use a version exposing both `run` and `run_batch` (the reviewed reference is 0.1.7).

## Calls and isolation

The parent must start with `CLAUDE_CODE_MCP_AUTO_BACKGROUND_MS=0` and a client MCP timeout of at least 7200 seconds. These are parent-host settings, not worker arguments. If the host backgrounds or rejects a call, report it and fix the host setup; do not replace the wait with polling.

For one implementation worker authorized to commit in a standalone clone, call `run` with these fields. Use the actual assigned checkout and an unused delegation ID.

```json
{
  "cwd": "/absolute/path/isolated-checkout",
  "delegation_id": "feature-w1-001",
  "prompt": "<self-contained assigned task, ownership, contracts and acceptance>",
  "model": "gpt-6.1-sol",
  "effort": "high",
  "sandbox": "workspace-write",
  "writable_roots": ["/absolute/path/isolated-checkout/.git"],
  "timeout_seconds": 3600
}
```

For independent tasks use one `run_batch` call with `batch_id` and `tasks`. Each of the 1–5 task entries has its own `task_id` plus the same run fields above, unique delegation ID and distinct non-overlapping checkout. Adjust writable roots to each role; omit the Git root for QA that only executes checks. Five is the transport limit, not a target worker count. Integration runs after the required tasks return, never concurrently against a worker's checkout.

Use `prompt` or a `prompt_file` under that worker's `cwd/artifacts`, never both. Prefer `prompt_file` for long briefs; write the file once with file-writing tools, not a long command heredoc. Require chat handoffs of at most 15 lines linked to detailed evidence. Carry the ownership/acceptance brief into the assigned task. Do not claim the worker inherited the coordinator's history or browser connection.

Use `workspace-write` for implementation. Pass any necessary, already-authorized `writable_roots` and `network_access` explicitly, including on resume; keep writable areas disjoint across a batch. Full access requires explicit authorization and must not be an automatic response to a permission failure. Codex may keep `.git` read-only even in a standalone clone. For a worker authorized to commit, resolve its Git metadata paths and include the needed paths explicitly before dispatch. The example assumes a standalone clone with its own `.git` directory. QA that only executes checks does not need Git write access. Do not grant every worker write access to the integration checkout.

For workers needing Git writes, use a plain local clone: `git clone <path-to-main-checkout> <run-id>-<worker>`. It has its own `.git`; Git hardlinks immutable object files where possible, keeping object storage cheap. Do not use `--no-hardlinks` (full object copy), or `--shared`/`--reference` without `--dissociate` (borrowed objects can disappear when the source prunes). See [git-clone](https://git-scm.com/docs/git-clone). Install dependencies in the checkout with the project's package manager, using its shared store where supported; never copy `node_modules` or build output. Reuse the checkout for corrections; remove it at run close under the skill's cleanup rules. Worktrees remain fine for QA that does not write Git metadata.

## Smoke and QA access and isolation

Browser/Electron smoke and acceptance QA each use their own `gpt-6.1-sol` Farcall session, separate from implementation. Set `effort: medium` only for fixed-checklist smoke; implementation, integration and acceptance QA require `effort: high`. Early smoke runs get sampled against high acceptance QA under the [acceptance contract](acceptance.md); return smoke to high if medium finds substantially fewer issues and record the reason. Haiku is never the browser/GUI fallback.

Both smoke and QA use direct completion waits in fresh sessions with the role-specific effort above. Give each an isolated checkout at the integrated commit and separate ports, databases and test data. It may write evidence and explicitly assigned test files, but not product code. Before resuming that same QA session, the coordinator prepares its checkout at the new integrated commit and restarts/rebinds the runtime, preserving existing evidence and unresolved drafts. QA verifies the hash and runtime revision. Do not force away local changes. If QA is explicitly assigned regression-test commits, grant its own Git metadata write access for that task and send those commits through the integrator.

Verify actual browser/Electron access inside that session before declaring live testing available. Parent tools, profiles and connections are not inherited. Use only the configured and authorized host/browser surface. Do not work around a blocked connection with a different browser, personal profile or broader permissions. Keep missing checks open and agree an available alternative with the user, such as restoring access in the assigned QA session. Existing authorization remains valid; do not ask again for already approved access.

## Settings evidence

Check the parent's actual session model and effort before implementation. For the worker, compare the call arguments with Farcall's saved execution and the matching native Codex session metadata (`turn_context` model and reasoning effort, where available). Record the assigned role/checklist and compare actual effort against it: medium is valid only for fixed-checklist browser/Electron smoke, never for implementation, integration or acceptance QA. Check a documented return to high for smoke against available execution metadata; unavailable fields remain `unknown`. Scope reads to the returned session ID; do not inspect unrelated sessions.

Farcall 0.1.7 records `requested_model`, `requested_effort`, `session_id` and `evidence_directory`. The Codex adapter may be unable to report a verified executed model ID, leaving `reported_model` as `unknown`. The request fields prove the launch configuration, not independently the served model. Report each evidence level accurately. Stop dispatch for a confirmed model/effort mismatch, not absent evidence. Record unavailable verification as `unknown`, keep requested settings explicit and continue without claiming the served settings are verified. Before requiring verified execution, name a supported evidence source and confirm its availability. Session configuration metadata and request fields must not be presented as independent served-model proof. This evidence gap is distinct from an unknown worker outcome, which still requires the recovery procedure below. No preflight/model call solely to ask a model its own name.

## Completion, corrections and recovery

Context maintenance and coordinator replacement follow the [continuity contract](coordination.md). Persist task/attempt IDs and dispatch intent before calling; save returned batch/session/delegation IDs and result/event records afterward. No compaction during a pending direct wait: checkpoint before dispatch and request manual compaction after return. If delivery is lost, recover the unknown outcome without redispatch. After compaction, reconcile records before more work. Replace only with completed waits/children and durably reconciled results, or verified host transfer; preserve direct completion semantics. Task IDs identify results but require shared artifacts and working delivery/recovery. Never redispatch for a missing notice or add progress polling.

- Resume/retry records live in `artifacts/farcall/<delegation_id>/` inside the worker checkout. Before removing that checkout, copy records for resumable sessions into the coordinator's `artifacts/<run-id>/`, retaining delegation IDs. Never delete the records or checkout while `artifacts/farcall/.active` exists. Aborted or timed-out runs keep their checkouts; unknown worker outcomes block cleanup.
- Read each result, not only the batch's overall status. `completed` means the CLI returned, not that acceptance criteria passed. If `result_truncated` is true, read the needed part of `result_file` instead of rerunning.
- Record the exact returned `session_id` and `delegation_id` per worker, with its checkout. Resume corrections with both `resume_session_id` and `resume_delegation_id`, the same model/effort and needed permissions, and a new delegation ID. Batch corrections also need a new batch ID.
- Never use an implicit latest session or resume an `unknown` ID. If a session is lost, report it before a replacement is assigned.
- An identical request with the same ID returns its saved result. Reusing an ID with changed arguments is an error. A cached response proves no fresh execution.
- On timeout, interruption or recovery status, inspect the returned recovery evidence once. If the outcome is still unknown, report it and pause that work. Do not redispatch under fresh IDs, poll status or route around the failure.
- Do not enable full traces by default. Retain the transport's normal session/retry records; use traces only for a requested audit or diagnosed transport issue. Do not sum possibly cumulative usage fields.
