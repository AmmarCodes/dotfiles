# Phase 1: Wait for Pipeline to Finish

Use `pipeline-watch.py` (from the `gitlab-pipeline-watch` skill) in a polling loop. Each invocation blocks for up to 15 minutes (staying within tool-call timeout limits), then re-invoke if the pipeline is still running. **Never give up on a running pipeline.**

Locate pipeline-watch.py from the installed `gitlab-pipeline-watch` skill's `scripts/` directory.

```pseudocode
WAIT_FOR_PUSH=false   # set to true after pushing a fix or retrying

loop:
    if WAIT_FOR_PUSH:
        output=$(python3 pipeline-watch.py "$PROJECT_PATH" \
          --no-all --no-watch-new "$MR_IID" \
          --wait-for-push --timeout 900)
    else:
        output=$(python3 pipeline-watch.py "$PROJECT_PATH" \
          --no-all --no-watch-new "$MR_IID" \
          --timeout 900)

    if output contains "SUCCESS" → pipeline green, proceed to report
    if output contains "FAILED"  → proceed to Phase 2
    if output contains "CANCELED" → post comment, exit
    if timeout (no event)        → loop again
```

**CRITICAL**: Use `timeout=960000` (16 min) on the Bash tool call so it outlasts the 900s script timeout. The script exits cleanly on timeout — it's not an error, just means the pipeline is still running.

After the watcher reports a terminal state, get the structured JSON:

```bash
bash scripts/pipeline_status.sh "$MR_URL"
```

Check `blocking_failure_count`: if 0 but status is `failed`, all failures are `allow_failure: true` (non-blocking). Treat as green.
