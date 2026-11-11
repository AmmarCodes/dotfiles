## Delegation

- Delegate only when it saves real work: `explorer` for wide searches, `worker` for scoped edits, `tester` for running checks. Do small things directly.
- For code reviews, use the `/code-review` skill.
- Don't spawn every role by default. After subagents return, integrate and verify their results yourself.

## Loops and goals

- When starting ralph-loop, always pass `--max-iterations` (default to 10 if unsure).
- If a Stop-hook or loop goal needs something only the user can provide (content, credentials, a decision), stop and ask. Don't retry.
- If the same check fails twice in a row with no progress, stop and change the plan or report. Don't try a third time.
- A Stop-hook check that was already failing before this session isn't yours to fix: say so and stop.

## Changes

- Every changed line must trace back to the request. Don't "improve" adjacent code, formatting, fonts, copy or dependency versions; mention them instead.
- Remove only what your own change made unused; mention pre-existing dead code, don't delete it.
- Before implementing, state assumptions that would change the result. If the request has more than one reasonable reading, ask instead of picking.
