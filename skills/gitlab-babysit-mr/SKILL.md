---
name: gitlab-babysit-mr
description: Monitor a GitLab MR's pipeline until green. Classifies failures (flaky, master-broken, lint, coverage, real), retries jobs where appropriate, makes light-touch auto-fixes, and posts findings as an MR comment.
version: 0.10.0
category: Development Workflow
license: MIT
compatibility: opencode
argument-hint: <URL of the MR to babysit>
metadata:
  audience: developers
  workflow: gitlab
---

# gitlab-babysit-mr

Nurse a GitLab MR's pipeline to green by classifying failures, retrying flaky/broken jobs, making light-touch auto-fixes, and posting structured reports inside a resolved discussion thread on the MR.

## Dependencies

- **Bundled scripts** — `scripts/` directory (pipeline_status.sh, job_log_tail.sh, search_known_issues.sh)
- **gitlab-pipeline-watch skill** — provides `pipeline-watch.py` for blocking pipeline polling

## Main Loop (max 5 action rounds)

The loop caps **action rounds** (classify + retry/fix), NOT status checks. The babysitter waits as long as the pipeline needs — it only counts a round when it takes action on failures.

```pseudocode
Phase 0: Resolve MR URL → PROJECT_PATH, MR_IID, PROJECT_ENCODED

ACTION_ROUND = 0, MAX_ROUNDS = 5
JOB_RETRY_COUNT = {}      # keyed by job name, persisted across rounds
DUO_LINT_REQUESTED = {}   # keyed by job name, tracks Duo Developer requests
DISCUSSION_ID = null      # set after first report, reused for thread replies

while ACTION_ROUND < MAX_ROUNDS:
    Phase 1: Wait for pipeline terminal state (SUCCESS/FAILED/CANCELED)
    Phase 2: Analyze each failed job (fetch log tail, classify)
    Phase 3: Search for known issues (FLAKY and MASTER_BROKEN only)
    Phase 4: Take action per classification
    Phase 5: Post report in resolved discussion thread
    Phase 6: Diagnose blocking failures before final report
    Phase 7: Loop back if action taken, else post final report and exit
```

## Phases — Reference Files

Each phase has detailed instructions in a reference file. Load on demand.

| Phase | Summary | Reference |
|-------|---------|-----------|
| **0** | Resolve MR from argument or current branch | [references/mr-resolution.md](references/mr-resolution.md) |
| **1** | Poll with pipeline-watch.py in 15-min windows; never give up on running pipelines | [references/pipeline-watching.md](references/pipeline-watching.md) |
| **2–3** | Fetch job logs, classify failures, search known issues | [references/job-analysis.md](references/job-analysis.md) |
| **4** | Retry flaky jobs, retry pipelines, delegate lint to Duo Developer | [references/failure-actions.md](references/failure-actions.md) |
| **5** | Post report in a resolved discussion thread (collapsed by default) | [references/mr-reporting.md](references/mr-reporting.md) |
| **6** | Root-cause diagnosis for blocking failures | [references/failure-diagnosis.md](references/failure-diagnosis.md) |
| **7** | Set `WAIT_FOR_PUSH=true` and loop, or exit if no actions possible | — |

**Classification guide:** [references/failure-classification.md](references/failure-classification.md) — FLAKY, MASTER_BROKEN, LINT, COVERAGE, REAL_FAILURE, UNKNOWN.

**Lint fix delegation:** [references/lint-fix-delegation.md](references/lint-fix-delegation.md) — Duo Developer comment → wait → local fallback.

## Safety Rules

- **Max 2 retries per job** — track by name; 3rd failure → pipeline retry
- **Never retry REAL_FAILURE** — needs code fixes, not retries
- **Max 5 action rounds** — caps retries/fixes, NOT waiting time
- **Never give up on a running pipeline** — re-invoke pipeline-watch.py in 15-min windows
- **Skip `allow_failure: true` jobs** — non-blocking by design
- **No force-push or amend** — always new commits for fixes
