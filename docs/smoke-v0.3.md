# 0.3 live smoke

[Back to verification](evaluation.md)

Run on 2026-10-03 against the installed 0.3 candidate in a disposable Python standard-library CLI. The task was to reject changed-content retries without mutating the stored note. The coordinator used the installed orchestration skill; one Sol session implemented & integrated, a fresh Sol session performed QA, and Opus reviewed the integrated diff & evidence.

## Execution evidence

| Role | Evidence |
|---|---|
| Coordinator | The outer Farcall Claude worker reported `claude-opus-5-5`; launch effort high, process environment `CLAUDE_EFFORT=high` |
| Implementer/integrator | Native Codex `turn_context` recorded `gpt-6.1-sol` / high for both initial & resumed turns |
| Fresh QA | A separate native Codex session recorded `gpt-6.1-sol` / high |
| Completion waits | Coordinator trace contained three direct Farcall calls and their results; no worker-status polling calls |
| Integration | Worker branch at `89715bae8481b35376ae5121b83026037b0a1b12`, clean |
| QA | Separate clean clone of that exact commit; no product edits |
| Source | Original fixture main at `00d61419321e3cd03e11fc551e3c90386efe5282`, unchanged |

These hashes identify the disposable fixture, not commits in this plugin repository. Farcall's Codex `reported_model` field was unknown; matching native session metadata supplied the model/effort evidence. This establishes recorded execution settings, not independent attestation of a remote provider's internals.

## Observed outcomes

QA invoked `python3 note.py --store <isolated-file> put --id <id> --value <value>` and `get`. Each step recorded stdout, stderr, exit code, stored JSON & file hash.

| Scenario | Result |
|---|---|
| First operation stores `hello` | Exit 0; file & subsequent read agree |
| Identical retry | Exit 0; same result; file unchanged byte-for-byte |
| Same ID with changed content | Exit 2; conflict on stderr, no success output; file unchanged |
| Read after rejected retry | Exit 0; still `hello` |
| New ID stores `world` | Exit 0; both operation IDs retained |
| Read after new operation | Exit 0; `world` |
| Old ID with changed content after newer save | Exit 2; latest value & file bytes preserved |

The persisted final file's SHA-256 was `4baa1b90c1a6f08ef77fa0c21e29822bbbb9efd95a8d2b6f51122d3160c40988`. The coordinator inspected the diff and independently reconciled the hashes. `python3 -m unittest discover -v` passed one subprocess regression test covering the retry sequence. Implementer, QA & coordinator each ran this small test; this is not evidence that redundant verification has been eliminated.

## Recovery & limits

The initial worker commit failed because `.git` was read-only. The coordinator resumed the exact same worker session with the clone's Git directory as an authorized writable root. This succeeded without broader sandbox access or a replacement worker. The final Farcall instructions include this lesson; that final wording was checked locally after the live run.

The CLI had no browser/Electron surface. UI read/write failures, delayed-save races, concurrent browser sessions, multiple implementers, product-fix QA resumes & optional fresh review remain untested by this smoke. This is a narrow workflow check, not a full acceptance or cost benchmark.

Raw sessions, QA command evidence & fixture repositories are retained locally under `artifacts/live-0.3/`, excluded from the published plugin. Coordinator session `d9cba2bb-142b-44e3-a586-71c90045220e`, implementation session `01a101b5-7280-7c63-80dd-ab8ee923187c`, QA session `01a101b7-4549-70b1-89d0-1ee759ecff68`.
