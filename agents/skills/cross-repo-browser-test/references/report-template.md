# Report template

Lead with the verdict; keep each finding short enough to paste into an MR.

```markdown
**Verdict:** <works | works with issues | blocked> — <one sentence why>.
Tested <repo A> `<branch>` with <repo B> `<branch>`. <Check results: format, lint, N unit tests, build.>

## Findings

### In this change
1. **<Short title>** (`path/file.ext:line`)
   - Reproduce: <steps>
   - Cause: <root cause, traced to where the value is set>
   - Fix: <smallest change>

### In <dependency> branch / environment / pre-existing
1. **<Short title>** — same shape. Say whether it's already on main.

### Minor / UX
- <one line each>

## Passed
| Area | Evidence |
|---|---|
| <flow> | <what you saw: counts matched DB, mail arrived with names filled in, 403 for restricted role…> |

## Not covered
- <area> — <why: couldn't sign in as that user, needs a real provider, out of time…>

## Local state changed
- <branches switched, settings changed, users/rows created, toggles restored>
```

When comparing with a code review, add a table: finding → verdict (correct /
overstated / wrong) → what the code shows → whether the browser tests would
have caught it.
