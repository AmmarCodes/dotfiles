# Commit Format Reference

Complete guide to commit message formatting, line wrapping, and conventions.

## Contents
- Subject line rules
- Body format and wrapping
- Long URLs
- Issue references
- Conventional Commits compatibility

## Subject Line Rules

| Rule | Example | Violation | Why |
|------|---------|-----------|-----|
| Capitalize first word | `Add CPU arch filter` | `add CPU arch filter` | Sentence case always |
| Imperative mood | `Fix null pointer` | `Fixed null pointer` | Command form: Add/Fix/Remove |
| 72 char max | `Add CPU arch filter support` | `Add CPU architecture filter to scheduler...` | Hard limit |
| No trailing period | `Add user auth` | `Add user auth.` | Subject is title, not sentence |
| No scope prefix | `Fix null pointer in auth` | `auth: fix null pointer` | Unless Conventional Commits |
| Meaningful standalone | `Add CPU arch filter support` | `Fix #847` | Readable outside platform |

```bash
# ✅ Correct
Add CPU arch filter scheduler support

# ❌ Wrong
added cpu arch filter scheduler support    # lowercase, past tense
```

## Body Format and Wrapping

### Blank line after subject (critical)

```bash
# ✅ Correct
Add CPU arch filter support

In a mixed environment of x86 and ARM nodes, the scheduler
could not distinguish architectures.

# ❌ Wrong (no blank line)
Add CPU arch filter support
In a mixed environment of x86 and ARM nodes...
```

### Wrap at 72 characters

Exception: URLs and code that can't be split.

### Explain WHY, not WHAT

The diff shows what changed; the message explains why:

```bash
# ✅ Correct
Add CPU arch filter support

In a mixed environment of x86 and ARM nodes, the scheduler
could not distinguish architectures, causing crashes.

# ❌ Wrong (only describes WHAT)
Add CPU arch filter support

Added arch label to nodes and filter to algorithm.
```

### Describe effects and limitations

```bash
Add CPU arch filter support

Enables workloads to be scheduled only on compatible
architectures. Current limitation: only x86 and ARM
supported. New architectures require updating enum.
```

## Long URLs

Put URLs on their own line or use reference-style:

```bash
# Option 1: URL on own line
Implement the technique described at:

https://example.com/very/long/url/exceeds/72/chars

# Option 2: Reference-style
Implement the technique at [1] to prevent exhaustion.

[1] https://example.com/very/long/url/exceeds/72/chars
```

## Issue References

**Only add if project uses them** (check `git log --oneline -20`).

Put in **body** on **own line** at end:

```bash
# ✅ Correct
Add CPU arch filter support

[explanation]

Fixes #847

# ❌ Wrong (in subject)
Fix #847: Add CPU arch filter
```

**Keywords:** `Fixes #N`, `Closes #N`, `Resolves #N` (GitHub/GitLab), `PROJ-123` (Jira)

## Full Example

```
Add CPU arch filter scheduler support

In a mixed environment of x86 and ARM nodes, the scheduler
previously could not distinguish between architectures,
leading to binary incompatibility crashes.

Add an arch label to each node and a corresponding filter
in the scheduling algorithm. This enables workloads to be
scheduled only on compatible architectures.

Current limitation: only x86 and ARM are supported. Adding
new architectures requires updating the label enum.

Fixes #847
```

## Conventional Commits Compatibility

If project uses Conventional Commits, use this format:

```bash
<type>(<scope>): <subject>

feat(scheduler): add CPU arch filter support
fix(auth): handle null session token
chore(deps): update lodash to 4.17.21
```

**Common types:**
- `feat:` - new feature
- `fix:` - bug fix
- `chore:` - maintenance
- `docs:` - documentation
- `refactor:` - code change (no fix/feature)
- `test:` - tests
- `perf:` - performance

All other rules still apply (imperative, 72-char limit includes prefix, body explains WHY).

## Gotchas

- **72-char limit includes type prefix** — `feat(scheduler): ` counts toward 72
- **Blank line is critical** — many tools parse on this boundary
- **Issue refs in body, not subject** — keeps subject meaningful
- **URLs break wrapping rule** — put on own line
- **Capitalize after colon** — `feat: Add auth` not `feat: add auth` (unless project uses lowercase)
