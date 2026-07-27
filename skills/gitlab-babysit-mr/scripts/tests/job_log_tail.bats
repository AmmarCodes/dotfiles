#!/usr/bin/env bats

setup() {
  SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SCRIPT_PATH="${SCRIPT_DIR}/job_log_tail.sh"
  export PATH="$BATS_TEST_TMPDIR:$PATH"
  export MOCK_JOB_JSON='{"id":123,"name":"rspec","stage":"test","status":"failed","failure_reason":"script_failure","web_url":"https://example.com/jobs/123","allow_failure":false,"runner":{"description":"runner-1"},"started_at":"2025-01-01T00:00:00Z","finished_at":"2025-01-01T00:01:00Z"}'
}

write_mock_glab() {
  cat >"${BATS_TEST_TMPDIR}/glab" <<'EOF'
#!/usr/bin/env bash
for arg in "$@"; do
  case "$arg" in
    *jobs/*/trace)
      case "${MOCK_SCENARIO:-}" in
        basic)
          printf 'Line 1\nLine 2\nTest output here\nTest failed: expected true got false\n'
          ;;
        ansi)
          printf '\x1b[31mERROR\x1b[0m: test failed\nNormal line\n'
          ;;
        sections)
          printf 'section_start:1234:setup\r\nSetting up environment\nsection_end:1234:setup\r\nActual test output\n'
          ;;
        lines-10)
          for i in $(seq 1 10); do
            printf 'Line %s\n' "$i"
          done
          ;;
        lines-200)
          for i in $(seq 1 200); do
            printf 'Line %s\n' "$i"
          done
          ;;
        *)
          printf 'Default log\n'
          ;;
      esac
      exit 0
      ;;
    *jobs/*)
      printf '%s' "${MOCK_JOB_JSON}"
      exit 0
      ;;
  esac
done
exit 1
EOF
  chmod +x "${BATS_TEST_TMPDIR}/glab"
}

extract_job_info() {
  printf '%s\n' "$1" | awk '
    /^=== JOB INFO ===$/ {found=1; next}
    /^=== JOB LOG/ {exit}
    found {print}
  '
}

extract_job_log() {
  printf '%s\n' "$1" | awk '
    /^=== JOB LOG/ {found=1; next}
    found {print}
  '
}

@test "exits non-zero with no arguments" {
  run "$SCRIPT_PATH"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "exits non-zero with only one argument" {
  run "$SCRIPT_PATH" "mygroup%2Fmyproject"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* ]]
}

@test "outputs correct structure with JOB INFO and JOB LOG sections" {
  export MOCK_SCENARIO="basic"
  write_mock_glab

  run "$SCRIPT_PATH" "mygroup%2Fmyproject" "123"

  [ "$status" -eq 0 ]
  [[ "$output" == *"=== JOB INFO ==="* ]]
  [[ "$output" == *"=== JOB LOG"* ]]

  job_info="$(extract_job_info "$output")"
  echo "$job_info" | jq -e '
    has("id") and
    has("name") and
    has("stage") and
    has("status") and
    has("failure_reason") and
    has("web_url") and
    has("allow_failure") and
    has("runner") and
    has("started_at") and
    has("finished_at") and
    .id == 123 and
    .name == "rspec" and
    .runner == "runner-1"
  ' >/dev/null
}

@test "strips ANSI escape codes from log output" {
  export MOCK_SCENARIO="ansi"
  write_mock_glab

  run "$SCRIPT_PATH" "mygroup%2Fmyproject" "123"

  [ "$status" -eq 0 ]
  job_log="$(extract_job_log "$output")"
  [[ "$job_log" != *$'\x1b['* ]]
  [[ "$job_log" == *"ERROR: test failed"* ]]
}

@test "removes GitLab CI section markers from log output" {
  export MOCK_SCENARIO="sections"
  write_mock_glab

  run "$SCRIPT_PATH" "mygroup%2Fmyproject" "123"

  [ "$status" -eq 0 ]
  job_log="$(extract_job_log "$output")"
  [[ "$job_log" != *"section_start"* ]]
  [[ "$job_log" != *"section_end"* ]]
  [[ "$job_log" == *"Setting up environment"* ]]
  [[ "$job_log" == *"Actual test output"* ]]
}

@test "respects custom line count (3rd argument)" {
  export MOCK_SCENARIO="lines-10"
  write_mock_glab

  run "$SCRIPT_PATH" "mygroup%2Fmyproject" "123" "3"

  [ "$status" -eq 0 ]
  job_log="$(extract_job_log "$output")"
  line_count="$(printf '%s\n' "$job_log" | wc -l | tr -d ' ')"
  [ "$line_count" -eq 3 ]
  [[ "$job_log" == *"Line 8"* ]]
  [[ "$job_log" == *"Line 10"* ]]
}

@test "defaults to 150 lines when no line count specified" {
  export MOCK_SCENARIO="lines-200"
  write_mock_glab

  run "$SCRIPT_PATH" "mygroup%2Fmyproject" "123"

  [ "$status" -eq 0 ]
  job_log="$(extract_job_log "$output")"
  line_count="$(printf '%s\n' "$job_log" | wc -l | tr -d ' ')"
  [ "$line_count" -eq 150 ]
  [[ "$job_log" == *"Line 51"* ]]
  [[ "$job_log" == *"Line 200"* ]]
  [[ "$job_log" != *"Line 50"* ]]
}
