# Failure Classification Guide

Read the last 150 lines of the job log and classify into one of:

## FLAKY
Random or infrastructure-related failures unrelated to the MR code:
- Connection timeouts, DNS failures, port conflicts (`Errno::EADDRINUSE`, `Net::ReadTimeout`, `SocketError`)
- "Could not connect", "connection refused", "connection reset"
- Test passes in other shards/jobs of the same type
- Intermittent Docker/runner issues
- `random seed` combined with failures that seem random
- "flaky" mentioned in the output

## MASTER_BROKEN
Shared code or infrastructure is broken for everyone, not specific to this MR:
- Error in code the MR did not touch (check `git diff origin/main --name-only`)
- Same root error in multiple unrelated jobs
- Database migration errors, gem version conflicts
- CI infrastructure errors (runner out of disk, registry unavailable)
- Missing fixtures or seed data that existed before

## LINT
Style/formatting violation:
- Job name contains: `rubocop`, `eslint`, `haml-lint`, `stylelint`, `prettier`
- RuboCop cop names: `Style/`, `Layout/`, `Metrics/`, `Lint/`
- ESLint format: `error  <rule>  <file>:<line>`
- "offenses detected", "x problems (y errors, z warnings)"

## COVERAGE
Code coverage below threshold:
- Job name contains: `coverage`, `code_coverage`
- Output: "Coverage (%) must be at least X%", `C0 coverage`

## REAL_FAILURE
Actual bug in MR code:
- Test failure in code the MR modified (correlate with `git diff origin/main --name-only`)
- Logic error, missing method, wrong behavior
- Expected/actual diff matches the MR's changes

## UNKNOWN
Cannot determine cause from log tail alone.
