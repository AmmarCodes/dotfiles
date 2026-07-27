#!/usr/bin/env bats

setup() {
  SCRIPT_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  SCRIPT_PATH="${SCRIPT_DIR}/search_known_issues.sh"
  export PATH="$BATS_TEST_TMPDIR:$PATH"
}

write_mock_glab() {
  cat >"${BATS_TEST_TMPDIR}/glab" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

repo=""
search=""
label=""

for ((i=1; i<=$#; i++)); do
  arg="${!i}"
  case "$arg" in
    -R)
      next_index=$((i+1))
      repo="${!next_index}"
      ;;
    --search)
      next_index=$((i+1))
      search="${!next_index}"
      ;;
    --label)
      next_index=$((i+1))
      label="${!next_index}"
      ;;
    -f)
      next_index=$((i+1))
      value="${!next_index}"
      if [[ "$value" == search=* ]]; then
        search="${value#search=}"
      fi
      ;;
  esac
done

if [[ -n "${GLAB_REPO_FILE:-}" && -n "$repo" ]]; then
  printf '%s\n' "$repo" >>"$GLAB_REPO_FILE"
fi

if [[ -n "${GLAB_SEARCH_FILE:-}" && -n "$search" ]]; then
  printf '%s\n' "$search" >>"$GLAB_SEARCH_FILE"
fi

if [[ "${1:-}" == "issue" && "${2:-}" == "list" ]]; then
  if [[ "${MOCK_FAIL_LABEL:-}" == "$label" ]]; then
    exit 1
  fi

  if [[ "$label" == "master broken" ]]; then
    printf '%s' "${MOCK_MASTER_ISSUES_JSON:-[]}"
    exit 0
  fi

  if [[ "$label" == "flaky-test" ]]; then
    printf '%s' "${MOCK_FLAKY_ISSUES_JSON:-[]}"
    exit 0
  fi

  printf '[]'
  exit 0
fi

if [[ "${1:-}" == "api" ]]; then
  if [[ "${MOCK_FAIL_LABEL:-}" == "api" ]]; then
    exit 1
  fi
  printf '%s' "${MOCK_MR_JSON:-[]}"
  exit 0
fi

exit 1
EOF
  chmod +x "${BATS_TEST_TMPDIR}/glab"
}

extract_section() {
  local header_regex="$1"
  local output="$2"

  printf '%s\n' "$output" | awk -v header="$header_regex" '
    $0 ~ header {found=1; next}
    found && $0 ~ /^=== / {exit}
    found {print}
  '
}

@test "exits non-zero with no arguments" {
  run "$SCRIPT_PATH"
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage"* || "$error" == *"Usage"* ]]
}

@test "outputs all three expected sections" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[]'
  export MOCK_FLAKY_ISSUES_JSON='[]'
  export MOCK_MR_JSON='[]'

  run "$SCRIPT_PATH" "test_failure"

  [ "$status" -eq 0 ]
  [[ "$output" == *"=== Master Broken Issues"* ]]
  [[ "$output" == *"=== Flaky Test Issues"* ]]
  [[ "$output" == *"=== Master Broken MRs"* ]]
}

@test "each section contains valid JSON" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[{"iid":1,"title":"Flaky test foo","web_url":"https://example.com/issues/1","state":"opened","created_at":"2025-01-01"}]'
  export MOCK_FLAKY_ISSUES_JSON='[{"iid":1,"title":"Flaky test foo","web_url":"https://example.com/issues/1","state":"opened","created_at":"2025-01-01"}]'
  export MOCK_MR_JSON='[{"iid":2,"title":"Fix master broken","web_url":"https://example.com/merge_requests/2","state":"opened","created_at":"2025-01-01"}]'

  run "$SCRIPT_PATH" "test_failure"

  [ "$status" -eq 0 ]

  master_issues="$(extract_section '^=== Master Broken Issues' "$output")"
  flaky_issues="$(extract_section '^=== Flaky Test Issues' "$output")"
  master_mrs="$(extract_section '^=== Master Broken MRs' "$output")"

  echo "$master_issues" | jq . >/dev/null
  echo "$flaky_issues" | jq . >/dev/null
  echo "$master_mrs" | jq . >/dev/null
}

@test "uses default repo gitlab-org/gitlab when no repo specified" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[]'
  export MOCK_FLAKY_ISSUES_JSON='[]'
  export MOCK_MR_JSON='[]'
  export GLAB_REPO_FILE="${BATS_TEST_TMPDIR}/repos"

  run "$SCRIPT_PATH" "test_failure"

  [ "$status" -eq 0 ]
  repo="$(awk 'NR==1 {print; exit}' "$GLAB_REPO_FILE")"
  [ "$repo" = "gitlab-org/gitlab" ]
}

@test "uses custom repo when specified" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[]'
  export MOCK_FLAKY_ISSUES_JSON='[]'
  export MOCK_MR_JSON='[]'
  export GLAB_REPO_FILE="${BATS_TEST_TMPDIR}/repos"

  run "$SCRIPT_PATH" "test_failure" "mygroup/myproject"

  [ "$status" -eq 0 ]
  repo="$(awk 'NR==1 {print; exit}' "$GLAB_REPO_FILE")"
  [ "$repo" = "mygroup/myproject" ]
}

@test "truncates long search terms to 80 characters" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[]'
  export MOCK_FLAKY_ISSUES_JSON='[]'
  export MOCK_MR_JSON='[]'
  export GLAB_SEARCH_FILE="${BATS_TEST_TMPDIR}/search_terms"

  long_term="$(printf 'a%.0s' {1..90})"
  expected="${long_term:0:80}"

  run "$SCRIPT_PATH" "$long_term"

  [ "$status" -eq 0 ]
  recorded="$(awk 'NR==1 {print; exit}' "$GLAB_SEARCH_FILE")"
  [ "$recorded" = "$expected" ]
}

@test "gracefully handles glab failures (falls back to empty array)" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[{"iid":10,"title":"Master broken","web_url":"https://example.com/issues/10","state":"opened","created_at":"2025-01-01"}]'
  export MOCK_FLAKY_ISSUES_JSON='[{"iid":11,"title":"Flaky","web_url":"https://example.com/issues/11","state":"opened","created_at":"2025-01-01"}]'
  export MOCK_MR_JSON='[{"iid":12,"title":"MR","web_url":"https://example.com/merge_requests/12","state":"opened","created_at":"2025-01-01"}]'
  export MOCK_FAIL_LABEL="flaky-test"

  run "$SCRIPT_PATH" "test_failure"

  [ "$status" -eq 0 ]

  master_issues="$(extract_section '^=== Master Broken Issues' "$output")"
  flaky_issues="$(extract_section '^=== Flaky Test Issues' "$output")"
  master_mrs="$(extract_section '^=== Master Broken MRs' "$output")"

  [[ "$flaky_issues" == "[]"* ]]
  echo "$master_issues" | jq -e '.[] | select(.iid == 10)' >/dev/null
  echo "$master_mrs" | jq -e '.[] | select(.iid == 12)' >/dev/null
}

@test "search term appears in Master Broken Issues header" {
  write_mock_glab
  export MOCK_MASTER_ISSUES_JSON='[]'
  export MOCK_FLAKY_ISSUES_JSON='[]'
  export MOCK_MR_JSON='[]'

  run "$SCRIPT_PATH" "NoMethodError"

  [ "$status" -eq 0 ]
  [[ "$output" == *"=== Master Broken Issues (searching: \"NoMethodError\") ==="* ]]
}
