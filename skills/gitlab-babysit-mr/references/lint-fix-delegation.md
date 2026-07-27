# Lint Fix Delegation — Duo Developer + Local Fallback

Instead of running lint fixes locally, delegate to Duo Developer by posting an MR comment. This triggers a remote AI workflow that pushes a fix commit.

## Step 1: Analyze the lint errors to build a clear instruction

From the job log tail, extract:
- Which files have violations (correlate with `git diff origin/main --name-only`)
- Which linter reported them (RuboCop cop names, ESLint rules, etc.)
- The specific violations (e.g. "Style/StringLiterals in app/models/foo.rb:42")

## Step 2: Post an MR comment mentioning Duo Developer

Compose a targeted instruction and post it as a **new top-level MR note** (not inside the babysitter discussion thread):

```bash
# Build the instruction from the lint errors found in Phase 2
DUO_INSTRUCTION="Fix the following lint violations in this MR:\n\n"
# Append each violation, e.g.:
# - RuboCop Style/StringLiterals in app/models/foo.rb:42 — use double quotes
# - ESLint no-unused-vars in app/assets/javascripts/bar.js:10
# Keep it specific: file paths, line numbers, rule names, and what to change.

# Write the comment body to a temp file to avoid shell quoting issues
# (lint output routinely contains backticks, quotes, and other metacharacters)
DUO_MSG=$(mktemp)
cat > "$DUO_MSG" << 'EOF'
@duo-developer-gitlab-org
EOF
# Append the instruction (already shell-safe in a variable)
printf '%s' "$DUO_INSTRUCTION" >> "$DUO_MSG"

glab api "projects/${PROJECT_ENCODED}/merge_requests/${MR_IID}/notes" \
  --method POST \
  --raw-field "body=$(cat "$DUO_MSG")"
rm -f "$DUO_MSG"
```

**Guidelines for the instruction:**
- Be specific: include file paths, line numbers, and rule names
- Group by linter (RuboCop, ESLint, HAML-lint, Prettier, Stylelint)
- For RuboCop: include the cop name (e.g. `Style/StringLiterals`)
- For ESLint/Prettier: include the rule name and whether `--fix` can resolve it
- Limit to violations in files the MR actually changed (from `git diff origin/main --name-only`)
- If there are too many violations (>20), focus on the blocking ones and ask Duo to run the auto-formatter

Example instruction:
```
Fix these RuboCop offenses in this MR:
- Style/StringLiterals in app/models/user.rb:42,58 — use double quotes
- Layout/TrailingWhitespace in app/controllers/foo_controller.rb:15,23

Run `bundle exec rubocop --autocorrect` on the affected files.
```

## Step 3: Wait for Duo Developer to push a fix commit

After posting the comment, set `WAIT_FOR_PUSH=true` and loop back to Phase 1. The pipeline watcher will use `--wait-for-push` to detect Duo Developer's new commit and the resulting pipeline.

## Step 4: Handle incomplete fixes

Do NOT post a second Duo Developer request for the same lint job — avoid a retry loop.

Track Duo Developer requests using a `DUO_LINT_REQUESTED` set (keyed by job name). Only request once per job:

```pseudocode
DUO_LINT_REQUESTED = {}   # persisted across action rounds, keyed by job name

for each LINT job:
    if job_name not in DUO_LINT_REQUESTED:
        # Post @duo-developer-gitlab-org comment with fix instructions
        DUO_LINT_REQUESTED[job_name] = true
        note: "Requested Duo Developer fix for lint violations"
    else:
        # Already requested once — Duo's fix didn't fully resolve it
        # Fall back to local auto-fix before giving up
        LOCAL_FIX_ATTEMPTED = try_local_autofix(job)
        if LOCAL_FIX_ATTEMPTED:
            note: "Duo Developer fix incomplete — attempting local auto-fix"
        else:
            classify as REQUIRES_MANUAL_FIX
            note: "Duo Developer fix incomplete, local auto-fix unavailable — requires manual attention"
```

## Step 5 (fallback): Local auto-fix

If Duo Developer doesn't push within the timeout, or its fix doesn't resolve all violations, attempt local auto-fix as a last resort before classifying as `REQUIRES_MANUAL_FIX`. This requires the project's toolchain to be available locally.

```bash
# Detect which linters are available and run auto-fix on MR-changed files only
CHANGED_FILES=$(git diff origin/main --name-only)

# RuboCop (Ruby)
if command -v bundle &>/dev/null && bundle exec rubocop --version &>/dev/null; then
  echo "$CHANGED_FILES" | grep '\.rb$' | xargs -r bundle exec rubocop --autocorrect --force-exclusion
fi

# ESLint (JavaScript/TypeScript)
if command -v yarn &>/dev/null && { compgen -G ".eslintrc*" || compgen -G "eslint.config*"; } &>/dev/null; then
  echo "$CHANGED_FILES" | grep -E '\.(js|ts|vue)$' | xargs -r yarn run eslint --fix
fi

# Prettier (formatting)
if command -v yarn &>/dev/null && { compgen -G ".prettierrc*" || compgen -G "prettier.config*"; } &>/dev/null; then
  echo "$CHANGED_FILES" | grep -E '\.(js|ts|vue|css|scss)$' | xargs -r yarn run prettier --write
fi

# HAML-lint
if command -v bundle &>/dev/null && bundle exec haml-lint --version &>/dev/null; then
  echo "$CHANGED_FILES" | grep '\.haml$' | xargs -r bundle exec haml-lint --auto-correct
fi

# If any files were modified, commit and push
if ! git diff --quiet; then
  git add -u
  git commit -m "fix: auto-correct lint violations"
  git push
  WAIT_FOR_PUSH=false  # we pushed directly, no need to wait
fi
```

If Duo Developer does not push a commit within 15 minutes (detected when pipeline-watch times out with no new pipeline), attempt the local auto-fix fallback above. If that also fails or is unavailable, classify as REQUIRES_MANUAL_FIX.
