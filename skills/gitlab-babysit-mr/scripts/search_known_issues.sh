#!/usr/bin/env bash
# search_known_issues.sh - Search for known master-broken or flaky test issues/MRs
# Usage: ./search_known_issues.sh "<search-term>" [repo]
# Repo defaults to gitlab-org/gitlab
# Output: JSON arrays of matching issues and MRs

set -Eeuo pipefail

error_handler() {
  echo "Error: Command failed at line $1 with exit code $2" >&2
}

trap 'error_handler $LINENO $?' ERR

SEARCH_TERM="${1:-}"
REPO="${2:-gitlab-org/gitlab}"
REPO_ENCODED="${REPO//\//%2F}"

if [[ -z "$SEARCH_TERM" ]]; then
  echo "Usage: $0 '<search-term>' [repo]" >&2
  exit 1
fi

# Truncate search term to avoid overly long API requests
SEARCH_SHORT="${SEARCH_TERM:0:80}"

echo "=== Master Broken Issues (searching: \"${SEARCH_SHORT}\") ==="
glab issue list \
  -R "$REPO" \
  --search "$SEARCH_SHORT" \
  --label "master broken" \
  --state opened \
  --output json \
  2>/dev/null |
  jq '[.[] | {iid, title, web_url, state, created_at}]' || echo "[]"

echo ""
echo "=== Flaky Test Issues ==="
glab issue list \
  -R "$REPO" \
  --search "$SEARCH_SHORT" \
  --label "flaky-test" \
  --state opened \
  --output json \
  2>/dev/null |
  jq '[.[] | {iid, title, web_url, state, created_at}]' || echo "[]"

echo ""
echo "=== Master Broken MRs ==="
glab api "projects/${REPO_ENCODED}/merge_requests" -X GET \
  -f "search=${SEARCH_SHORT}" \
  -f "labels=master broken" \
  -f "state=opened" \
  -f "per_page=5" \
  2>/dev/null |
  jq '[.[] | {iid, title, web_url, state, created_at}]' || echo "[]"
