# Atomic Commits Reference

Each commit should do ONE logical thing. This makes code easier to review, revert, and understand.

## The Core Principle

**One commit = one logical change**

If your subject line contains "and", you probably need two commits.

```bash
# ❌ Wrong — contains "and"
Refactor auth module and add user preferences endpoint

# ✅ Correct — split into two commits
Commit 1: Refactor auth module for reusability
Commit 2: Add user preferences endpoint
```

## Split Recommendations by Change Type

- **Refactoring** → Always separate from functional changes
- **Bug fixes** → One bug = one commit (even across multiple files)
- **Features** → One feature = one commit (or logical sub-parts)
- **Dependencies** → Group related deps, split unrelated

## Example: Good Split vs Bad Bundle

```bash
# ❌ Bad bundle
Refactor DB pool and add health check endpoint

Changed connection pool to singleton pattern, added
/health endpoint for load balancer checks, updated
error handling.

# ✅ Good split
Commit 1: Refactor DB connection pool to singleton

Previous per-request pool creation caused connection
exhaustion under high load. Switch to singleton with
configurable pool size.

Commit 2: Add health check endpoint for load balancers

Implements /health endpoint that returns 200 when DB
connection is healthy, 503 otherwise.
```

## Anti-Rationalizations

Don't bundle unrelated changes because:

- **"It's faster"** — Bundling saves 30 seconds now, costs hours when reverting or bisecting
- **"They're all small"** — Small unrelated changes are easier to split, not harder
- **"End of day"** — Time pressure is not a reason to violate commit hygiene

## Gotchas

- **Don't confuse "touches multiple files" with "multiple commits"** — a single logical change can span many files
- **When in doubt, split** — easier to squash later than to untangle a bundle
- **Use interactive rebase to split commits** — `git rebase -i` lets you edit/split
