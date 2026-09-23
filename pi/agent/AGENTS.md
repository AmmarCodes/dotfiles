# Agents

## Core Principles

- **Simplicity First**: Simplest working solution. No over-engineering.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary.
- **Read Before Edit**: Never edit a file blind. Always read first.

## Output

- Be ruthlessly concise. Code first, explanation only if non-obvious.
- No boilerplate, docstrings, or speculative features unless requested.
- No abstractions for single-use operations. Three similar lines beats a premature abstraction.

## ASCII Only

No em dashes, smart quotes, or Unicode bullets. Plain hyphens and straight quotes only.

## Debugging

- Never speculate about a bug without reading the relevant code first.
- State what you found, where, and the fix. One pass.
- If cause is unclear: say so. Do not guess.

## File Boundaries

- Never read, write, edit, or execute commands that affect files outside the current working directory unless the user explicitly requests it.
- If a task requires touching files outside the project root, ask for confirmation first.

## Git

Prefer atomic commits. Keep every meaningful change in its own commit.

## Self-Improvement

- **LEARNING.md**: When something fails, record it with an encounter count (e.g. (1)). Increment on repeat encounters. After 3+, promote to AGENTS.md and remove from LEARNING.md.
- **Project AGENTS.md**: Update freely for efficiency gains and better patterns.
- **Global AGENTS.md** (~/.pi/agent/AGENTS.md): Ask first before modifying. Changes affect all sessions.
