#!/usr/bin/env bash
# job_log_tail.sh - Get the tail of a GitLab CI job log
# Usage: ./job_log_tail.sh <project-encoded> <job-id> [lines]
# Output: Job metadata as JSON, then plain text log tail

set -Eeuo pipefail

error_handler() {
  echo "Error: Command failed at line $1 with exit code $2" >&2
}

trap 'error_handler $LINENO $?' ERR

PROJECT_ENCODED="${1:-}"
JOB_ID="${2:-}"
LINES="${3:-150}"

if [[ -z "$PROJECT_ENCODED" || -z "$JOB_ID" ]]; then
  echo "Usage: $0 <project-encoded> <job-id> [lines]" >&2
  exit 1
fi

# Get job metadata
echo "=== JOB INFO ==="
glab api "projects/${PROJECT_ENCODED}/jobs/${JOB_ID}" 2>/dev/null |
  jq '{
    id,
    name,
    stage,
    status,
    failure_reason,
    web_url,
    allow_failure,
    runner: .runner.description,
    started_at,
    finished_at
  }'

echo ""
echo "=== JOB LOG (last ${LINES} lines) ==="

# Get and clean job trace:
# - Strip ANSI escape codes
# - Remove GitLab CI section markers (section_start:/section_end:)
# - Remove carriage returns
glab api "projects/${PROJECT_ENCODED}/jobs/${JOB_ID}/trace" 2>/dev/null |
  sed 's/\x1b\[[0-9;]*[mGKHF]//g' |
  sed 's/\x1b\[[0-9]*[JK]//g' |
  sed '/^section_start:/d' |
  sed '/^section_end:/d' |
  sed 's/\r//g' |
  grep -v '^\s*$' |
  tail -n "$LINES"
