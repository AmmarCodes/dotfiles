---
name: commit-messages
description: Use when creating git commits, writing commit messages, or when about to run git commit -- enforces structured commit message format with imperative mood, capitalized subjects, 72-char wrapping, and atomic commits
version: 1.0.0
license: MIT
compatibility: opencode
metadata:
  audience: developers
  workflow: git
---

# Writing Commit Messages

## Overview

Every commit message follows a consistent format. The subject line completes the sentence: **"If applied, this commit will _\<your subject line\>_"**. When present, the body explains **why**, not what.

## Detect Project Convention First

Follow existing instructions for commits if present in the repository. Check `git log --oneline -20` to see recent patterns and match the existing style.

**Project convention always wins.** The rules below are the default when no convention is detected.

## References

Consider the following references when creating new commit messages:
- **Subject line rules, body format, URLs, issue references**: [references/COMMIT_FORMAT.md](references/COMMIT_FORMAT.md)
- **Split strategies, anti-rationalizations, and refactoring patterns**: [references/ATOMIC_COMMITS.md](references/ATOMIC_COMMITS.md)
- **Complete red flags checklist and mistake patterns**: [references/COMMON_MISTAKES.md](references/COMMON_MISTAKES.md)

## Attribution

**Author:** Andrew Fontaine ([@afontaine](https://gitlab.com/afontaine))

This skill is based on widely-accepted git commit message conventions, with inspiration from:

- [Commit Message Guidelines](https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53) by Robert Painsi
- [OpenStack GitCommitMessages](https://wiki.openstack.org/wiki/GitCommitMessages)
- [A Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) by Tim Pope
- [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/) by Chris Beams
