# Phase 0: Resolve the MR

Use the argument if provided. Otherwise detect from the current branch:

```bash
MR_URL="${ARGUMENT:-}"
if [[ -z "$MR_URL" ]]; then
  MR_URL=$(glab mr view --output json 2>/dev/null | jq -r '.web_url // empty')
fi

if [[ -z "$MR_URL" ]]; then
  echo "Error: no MR URL provided and none detected for current branch." >&2
  exit 1
fi
```

Parse the URL to extract project and MR IID:

```bash
# https://gitlab.com/group/[subgroup/]project/-/merge_requests/123
path="${MR_URL#https://gitlab.com/}"
PROJECT_PATH="${path%%/-/*}"
MR_IID="${MR_URL##*/}"
PROJECT_ENCODED="${PROJECT_PATH//\//%2F}"
```
