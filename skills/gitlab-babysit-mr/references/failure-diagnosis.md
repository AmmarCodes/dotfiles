# Failure Diagnosis — Blocking Failure Root-Cause Analysis

Before posting the final blocked report, attempt root-cause diagnosis for any failure classified as **REAL_FAILURE**, **MASTER_BROKEN**, **UNKNOWN**, or **REQUIRES_MANUAL_FIX**. This gives the MR author actionable information instead of just "requires manual fix".

## REAL_FAILURE diagnosis
1. Correlate the failing test file with MR changes: `git diff origin/main --name-only`
2. Read the failing test to understand what it asserts
3. Read the relevant source code that the MR changed
4. Summarize: which MR change likely caused which assertion to fail, and suggest a fix direction

## MASTER_BROKEN diagnosis
1. Check if the same job/test fails on the `main` branch pipeline (use `glab api "projects/${PROJECT_ENCODED}/pipelines?ref=main&status=failed&per_page=3"`)
2. Search for related open issues: `bash scripts/search_known_issues.sh "<error>" "<project>"`
3. If confirmed broken on main: note the issue URL and whether a fix MR exists
4. Summarize: what's broken, who owns it (if identifiable from issue), and whether a workaround exists

## UNKNOWN diagnosis
1. Fetch more log context (increase to 300 lines): `bash scripts/job_log_tail.sh "<project_encoded>" "<job_id>" 300`
2. Re-attempt classification with the additional context
3. If still unclassifiable: note the job URL and the most distinctive error line for manual inspection

## REQUIRES_MANUAL_FIX diagnosis
1. If this was a lint auto-fix that failed: note what went wrong and which files need manual attention
2. If this was a coverage drop: identify which files lost coverage by reading the coverage report section of the log

Include the diagnosis in the final report under each job's entry as a **Root cause** field.
