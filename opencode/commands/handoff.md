---
description: Create handoff document for context transfer
---

Create a HANDOFF.md file in the current working directory to transfer context to a new agent session.

Generate a comprehensive handoff document that allows a fresh agent to continue this task with zero additional context.

Structure the HANDOFF.md file as follows:

```markdown
# Task Handoff

## Original Request

[State the user's original request/goal clearly and completely]

## Current Status

[One-line summary: In Progress / Blocked / Nearly Complete]

## What Has Been Done

[List completed work with specific files modified and changes made]

## What Worked

[Document successful approaches, patterns that worked, key discoveries]

## What Didn't Work

[Document failed approaches with brief explanation of why they failed - this prevents the next agent from repeating mistakes]

## Remaining Tasks

[Numbered list of specific, actionable tasks to complete the work]

## Key Files

[List the most important files the next agent needs to read first]

## Context & Notes

[Any other critical information: gotchas, dependencies, environment requirements, relevant documentation]
```

Guidelines:

1. **Be specific**: Include file paths, function names, error messages
2. **Be actionable**: Remaining tasks should be concrete steps, not vague goals
3. **Prevent repetition**: Clearly document what failed so the next agent doesn't retry it
4. **Minimize ramp-up**: The next agent should be able to start working immediately after reading only HANDOFF.md

After creating the file, tell the user:

- The handoff file has been created at `./HANDOFF.md`
- The next agent can be started with: `opencode "Read HANDOFF.md and continue the task"`
