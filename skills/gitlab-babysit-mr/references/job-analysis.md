# Phases 2–3: Analyze Failed Jobs and Search Known Issues

## Phase 2: Analyze Each Failed Job

For each entry in `failed_jobs` where `allow_failure != true`:

```bash
bash scripts/job_log_tail.sh "<project_encoded>" "<job_id>" 150
```

If the log tail is insufficient to classify, gather more context:
- Run `git diff origin/main --name-only` to see which files the MR changed — compare against files mentioned in the error
- Check if the same job name failed in other recent pipelines (indicates FLAKY or MASTER_BROKEN, not REAL_FAILURE)
- Read the job's `failure_reason` field from the pipeline_status output (e.g. `script_failure` vs `stuck_or_timeout_failure`)

**Classify** the failure using [references/failure-classification.md](failure-classification.md). Record the classification for each job.

**Skip** jobs where `allow_failure: true` — they do not block the pipeline.

## Phase 3: Search for Known Issues

For **FLAKY** and **MASTER_BROKEN** failures, search for known issues:

```bash
# Use the most distinctive part of the error — test name, class name, or error message
bash scripts/search_known_issues.sh "<failure-keyword>" "<project>"
```

Good search terms (in order of specificity):
1. Exact test name: `FooSpec#bar_method`
2. Error class + method: `NoMethodError undefined method foo`
3. Job name if it's a known flaky job: `rspec-ee-unit`
