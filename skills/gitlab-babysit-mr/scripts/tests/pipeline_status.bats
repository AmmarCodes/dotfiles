#!/usr/bin/env bats

setup() {
  SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SCRIPT_PATH="$SCRIPT_DIR/pipeline_status.sh"
  export PATH="$BATS_TEST_TMPDIR:$PATH"

  cat >"$BATS_TEST_TMPDIR/glab" <<'EOF'
#!/usr/bin/env bash

for arg in "$@"; do
  case "$arg" in
    *pipelines?per_page*)
      case "${MOCK_SCENARIO:-default}" in
        no_pipeline)
          echo '[]'
          exit 0
          ;;
        success_pipeline|empty_jobs)
          echo '[{"id":100,"status":"success","web_url":"https://example.com/pipelines/100","sha":"abc12345"}]'
          exit 0
          ;;
        *)
          echo '[{"id":100,"status":"failed","web_url":"https://example.com/pipelines/100","sha":"abc12345"}]'
          exit 0
          ;;
      esac
      ;;
    *jobs?per_page*)
      case "${MOCK_SCENARIO:-default}" in
        paginated_jobs)
          echo '[{"id":1,"status":"failed","name":"rspec","stage":"test","failure_reason":"script_failure","web_url":"https://example.com","allow_failure":false,"retried":false}]'
          echo '[{"id":2,"status":"success","name":"lint","stage":"test","failure_reason":null,"web_url":"https://example.com","allow_failure":false,"retried":false}]'
          exit 0
          ;;
        empty_jobs)
          echo '[]'
          exit 0
          ;;
        retried_jobs)
          echo '[{"id":1,"status":"failed","name":"rspec","stage":"test","failure_reason":"script_failure","web_url":"https://example.com/jobs/1","allow_failure":false,"retried":true},{"id":2,"status":"failed","name":"lint","stage":"test","failure_reason":"script_failure","web_url":"https://example.com/jobs/2","allow_failure":false,"retried":false}]'
          exit 0
          ;;
        allow_failure_jobs)
          echo '[{"id":1,"status":"failed","name":"rspec","stage":"test","failure_reason":"script_failure","web_url":"https://example.com/jobs/1","allow_failure":true,"retried":false},{"id":2,"status":"failed","name":"lint","stage":"test","failure_reason":"script_failure","web_url":"https://example.com/jobs/2","allow_failure":false,"retried":false}]'
          exit 0
          ;;
        *)
          echo '[{"id":1,"status":"failed","name":"rspec","stage":"test","failure_reason":"script_failure","web_url":"https://example.com/jobs/1","allow_failure":false,"retried":false}]'
          exit 0
          ;;
      esac
      ;;
  esac
done

echo '[]'
exit 0
EOF

  chmod +x "$BATS_TEST_TMPDIR/glab"
}

run_pipeline_status() {
  stderr_file="$BATS_TEST_TMPDIR/stderr"
  run bash -c "\"$SCRIPT_PATH\" \"$1\" 2>\"$stderr_file\""
}

@test "exits non-zero with no arguments" {
  run "$SCRIPT_PATH"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "outputs valid JSON for a single-page pipeline" {
  run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq . >/dev/null
  echo "$output" | jq -e '.project and .mr_iid and .pipeline_id and .failed_jobs and .blocking_failure_count and .status_summary' >/dev/null
}

@test "handles paginated job responses (regression: pagination bug)" {
  MOCK_SCENARIO=paginated_jobs run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq . >/dev/null
  echo "$output" | jq -e '.status_summary.failed and .status_summary.success' >/dev/null
}

@test "handles empty jobs list without crashing" {
  MOCK_SCENARIO=empty_jobs run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq . >/dev/null
  echo "$output" | jq -e '.failed_jobs == [] and .blocking_failure_count == 0' >/dev/null
}

@test "returns error JSON when no pipeline exists" {
  MOCK_SCENARIO=no_pipeline run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq -e '.error and (.error | contains("No pipeline found"))' >/dev/null
}

@test "progress messages go to stderr, not stdout" {
  stderr_file="$BATS_TEST_TMPDIR/stderr"
  run bash -c "\"$SCRIPT_PATH\" https://gitlab.com/mygroup/myproject/-/merge_requests/42 2>\"$stderr_file\""
  [ "$status" -eq 0 ]
  stderr_contents="$(<"$stderr_file")"
  [[ "$stderr_contents" == *"Fetching"* ]]
  [[ "$output" != *"Fetching"* ]]
  echo "$output" | jq . >/dev/null
}

@test "correctly filters out retried jobs from failed_jobs" {
  MOCK_SCENARIO=retried_jobs run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq -e '.failed_jobs | length == 1 and .[0].id == 2' >/dev/null
}

@test "correctly counts blocking failures (excludes allow_failure jobs)" {
  MOCK_SCENARIO=allow_failure_jobs run_pipeline_status "https://gitlab.com/mygroup/myproject/-/merge_requests/42"
  [ "$status" -eq 0 ]
  echo "$output" | jq -e '.blocking_failure_count == 1' >/dev/null
}
