# Common Mistakes Reference

Red flags to catch before committing, with fixes and examples.

## Red Flags Checklist

Before committing, check for these issues:

- [ ] Subject starts with lowercase letter
- [ ] Subject uses past tense ("Fixed", "Added") or present participle ("Fixing", "Adding")
- [ ] Subject has scope prefix like `feat:`, `fix:`, `auth:` (unless project uses Conventional Commits)
- [ ] Subject ends with a period
- [ ] Subject exceeds 72 characters
- [ ] No blank line between subject and body
- [ ] Body only restates WHAT changed without explaining WHY
- [ ] Commit bundles unrelated changes (contains "and" in subject)
- [ ] Issue reference in subject line instead of body
- [ ] Vague subject like "Update stuff", "Fix bug", "WIP"

## Common Mistakes Table

| Mistake | Why Wrong | Fix |
|---------|-----------|-----|
| `fix: handle null token` | Lowercase, scope prefix (unless Conventional Commits) | `Handle null session token` |
| `Fixed the auth bug` | Past tense, vague | `Fix null pointer in session validation` |
| `Update stuff` | Vague | `Add expiration check to session tokens` |
| `Refactor DB pool and add prefs` | Two unrelated changes | Split: `Refactor DB pool` + `Add prefs endpoint` |
| Body: "Changed X to Y" | WHAT not WHY | "X caused crashes when Y, so..." |

## Before/After Examples

### Example 1: Lowercase + Past Tense

```bash
# ❌ Before
fixed auth bug

# ✅ After
Fix null pointer in session validation
```

### Example 2: Vague Subject

```bash
# ❌ Before
Update stuff

Some changes to the auth module.

# ✅ After
Add expiration check to session tokens

Session tokens were never expiring, allowing indefinite
access even after password changes. Add TTL validation
and auto-cleanup of expired tokens.
```

### Example 3: Bundled Changes

```bash
# ❌ Before
Refactor DB pool and add health check

Changed connection pool to singleton pattern and added
/health endpoint for load balancer checks.

# ✅ After (split into two commits)
Commit 1: Refactor DB connection pool to singleton

Previous per-request pool creation caused connection
exhaustion under high load.

Commit 2: Add health check endpoint for load balancers

Implements /health that returns 200 when DB healthy.
```

## Platform-Specific Notes

**Keywords are case-insensitive:** `Fixes #123` = `fixes #123`. See platform docs for issue linking: GitHub (`Fixes #N`), GitLab (`Closes #N`), Jira (`PROJ-123`), Gerrit (auto `Change-Id`).

## Gotchas

- **Blank line between subject and body is critical** — many tools parse on this
- **72-char limit is hard** — includes type prefix for Conventional Commits
- **Imperative test catches most mistakes** — "If applied, this commit will ___"
- **When in doubt, be more specific** — "Fix bug" tells future readers nothing
- **Don't amend commits already pushed to shared branches** — creates divergent history
