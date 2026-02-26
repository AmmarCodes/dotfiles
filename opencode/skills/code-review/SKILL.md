---
name: code-review
description: >
  Review code changes for quality, security, performance, and maintainability.
  Use when reviewing PRs, diffs, or code files. Provides structured feedback
  with severity levels.
---

# Code Review

Review code to improve overall codebase health while enabling developer progress.

## Core Principle

Approve changes that **improve code health**, even if imperfect. No "perfect" code exists—seek continuous improvement. Don't block PRs for nitpicks.

## Review Categories

### 1. Design (Critical)

- Does the change belong here or in a library?
- Do components interact sensibly?
- Is it over-engineered for problems that don't exist yet?
- Is now the right time for this change?

### 2. Security (Critical)

- Hardcoded secrets, API keys, credentials
- SQL injection, XSS, CSRF vulnerabilities
- Input validation and sanitization
- Auth/authz logic correctness
- Sensitive data exposure in logs/errors

### 3. Functionality (Critical)

- Does code do what author intended?
- Is that behavior good for users (end-users AND developers)?
- Edge cases handled?
- Race conditions or deadlocks in concurrent code?

### 4. Complexity (Important)

- Can code be understood quickly?
- Will devs introduce bugs modifying this?
- Functions/classes too long or doing too much?
- Over-abstraction or premature generalization?

### 5. Tests (Important)

- Tests added for new functionality?
- Tests are correct, sensible, useful?
- Will tests fail when code breaks?
- Edge cases covered?

### 6. Performance (Important)

- N+1 query problems
- Inefficient loops/algorithms
- Memory leaks, resource cleanup
- Missing caching opportunities

### 7. Naming & Readability (Suggestion)

- Names fully communicate purpose without being verbose
- Code explains itself; comments explain "why" not "what"
- Consistent style with codebase

### 8. Documentation (Suggestion)

- README/docs updated if behavior changes?
- Public API documented?

## Severity Levels

Use these prefixes in feedback:

- **`[Critical]`** — Must fix before merge (security, bugs, data loss)
- **`[Important]`** — Should fix, can discuss (perf, design, complexity)
- **`[Nit]`** — Nice to have, author can ignore (style, polish)

## Review Process

1. **Understand context** — Read the full change, check related files
2. **Check every line** — Don't skim human-written code
3. **Think like a user** — Both end-users and future developers
4. **Be specific** — Explain the "why" behind suggestions
5. **Acknowledge good patterns** — Positive feedback matters
6. **Ask questions** — When intent is unclear, ask don't assume

## Output Format

Structure feedback as:

```
## Summary
[1-2 sentence overall assessment]

## Critical Issues
- [Issue with explanation and suggested fix]

## Important Suggestions
- [Issue with explanation]

## Nits
- [Optional polish items]

## Good Patterns
- [Acknowledge what was done well]
```

## Anti-patterns to Flag

- Magic numbers/strings without constants
- Catch-all exception handlers hiding bugs
- Commented-out code left in
- TODO without issue reference
- Copy-pasted code (DRY violation)
- God objects/functions doing everything
- Tight coupling between unrelated components

## Principles

- Technical facts > opinions
- Style guide is authority for style
- Design decisions need engineering justification
- Consistency with codebase when no other rule applies
- Mentor through reviews—share knowledge
