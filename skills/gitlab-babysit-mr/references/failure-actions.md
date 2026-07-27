# Phase 4: Take Action by Classification

## FLAKY → Retry job (up to 2 retries per job; on 3rd failure, retry pipeline)

Track retry counts per job across action rounds using a `JOB_RETRY_COUNT` map (keyed by job name, since job IDs change on retry).

```pseudocode
JOB_RETRY_COUNT = {}   # persisted across action rounds, keyed by job name

for each FLAKY job:
    count = JOB_RETRY_COUNT.get(job_name, 0)
    if count < 2:
        # Retry the individual job
        glab api --method POST "projects/<project_encoded>/jobs/<job_id>/retry"
        JOB_RETRY_COUNT[job_name] = count + 1
        note: "Retried job (attempt #{count + 1} of 2)" + (known_issue_url or "no known issue found")
    else:
        # 3rd failure — escalate to full pipeline retry
        glab api --method POST "projects/<project_encoded>/pipelines/<pipeline_id>/retry"
        note: "Job failed 3 times — retried entire pipeline"
        break   # pipeline retry supersedes remaining individual retries
```

Search for known issues regardless of retry count (for reporting):
```bash
bash scripts/search_known_issues.sh "<failure-keyword>" "<project>"
```

## MASTER_BROKEN + known issue found → Retry pipeline (not just the job)
```bash
glab api --method POST "projects/<project_encoded>/pipelines/<pipeline_id>/retry"
```

## MASTER_BROKEN + no known issue
Check if the error is really master broken by inspecting code history. If confirmed, retry pipeline.

## LINT → Delegate fix to Duo Developer via MR comment

Follow the full lint fix delegation workflow: [references/lint-fix-delegation.md](lint-fix-delegation.md)

Summary: Post a `@duo-developer-gitlab-org` MR comment with specific violations, wait for Duo to push a fix, fall back to local auto-fix if incomplete. Track requests in `DUO_LINT_REQUESTED` to avoid retry loops.

## COVERAGE → Search for known coverage issues first
```bash
bash scripts/search_known_issues.sh "coverage" "<project>"
```
If found, retry. Otherwise classify as REQUIRES_MANUAL_FIX.

## REAL_FAILURE → No action. Document clearly in the report.

## UNKNOWN → Retry up to 2 times (same as FLAKY). If it fails a 3rd time, escalate to REQUIRES_MANUAL_FIX and diagnose in Phase 6.
