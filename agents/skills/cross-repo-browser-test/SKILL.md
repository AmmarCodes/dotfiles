---
name: cross-repo-browser-test
description: >
  Test a change end to end in the browser when it spans several connected
  services or repositories: a frontend MR/PR plus the API branch it calls,
  workers, queues, mail, webhooks and seeded data. Sets up the local stack on
  the right branches, routes side effects (mail, webhooks, payments) to safe
  local sinks, creates the dummy data the screens need, drives the UI in the
  built-in browser, cross-checks every number against the DB/API, and reports
  what works, what broke, and what was not covered. Use whenever the user wants
  to "test this MR/branch locally", "set up the environment to test X",
  "does this need dummy data", "check the feature works with the API", or asks
  to verify a review against real behaviour — even if they don't say "browser"
  or name the other services.
---

# Cross-repo browser test

Goal: an honest answer to "does this change work?", backed by things you saw
happen in the running system — not by reading the diff.

The work splits into six phases. Do them in order; each one feeds the next.
Keep the user's task list current, and stop to ask only at the points marked
**Ask** — everything else has a sensible default.

## 1. Map the change and its dependencies

Before touching anything, find out what the change needs from other systems.

- Read the change: `git diff --stat <base>...HEAD`, then the new or changed
  services/API clients, routes, hooks and pages. Note every endpoint, queue,
  mail, webhook, env var and permission it relies on.
- Read each repo's `README`, `AGENTS.md`/`CLAUDE.md`, `PROJECT_MEMORY.md` and
  `docs/known-issues.md` (when present) for how it runs locally.
- For each endpoint the client calls, check whether the backend's **default
  branch** serves it. If not, find the backend branch that does
  (`git branch -r`, matching branch names, MR links) and compare it to main
  (commits ahead/behind, new migrations, new config/env keys, new
  permissions, new scheduled jobs).
- Find how each service actually runs here: local process, Docker with source
  mounted, or a **built image** (then a rebuild is needed after switching
  branches). Check what is already running (`docker ps`, listening ports).

**Ask** (one message, with a short plan): which branches to check out, and
anything one-way — migrations that drop or move data, rebuilds that recreate
containers, changes to shared/staging environments. Name what can't be undone.
Also say plainly which screens need dummy data and why (see phase 3).

## 2. Bring up the stack on the right branches

- Check each repo is clean before switching branches; never stash or discard
  someone's work without asking.
- Switch branches, install dependencies with the project's own tooling, and
  rebuild images when the service runs from a built image. Run long builds in
  the background.
- Migrations: prefer the project's own path (an entrypoint that migrates on
  start, a make/compose target). Read the migration log for failures.
- **Side effects go to local sinks, never to real services.** Find every
  outbound channel the change touches and point it somewhere safe:
  - mail → a local catcher (Mailpit/MailHog); look for one already running in
    another compose stack before adding one. Check *every* mailer the feature
    uses — campaign/bulk mailers often have their own transport (e.g. SES)
    separate from the default one.
  - providers with quotas or accounts (SES quota checks, GeoIP downloads,
    payment providers, SMS) → their local/"configured"/test driver, or off.
  - webhooks from outside → you will simulate them in phase 4.
- **Secrets files (`.env`, credentials):** don't read or print them. If they
  need changes, give the user the exact lines to add (non-secret keys only)
  and wait. Verify the result through the app (e.g. print the effective
  config values that aren't secret) rather than by reading the file.
- Containers in different compose stacks don't see each other by default:
  attach to the other network (`docker network connect <net> <container>`)
  and note that it's lost when the container is recreated.
- Frontend: start it through `.claude/launch.json` + `preview_start` (create
  the file if missing and tell the user it's untracked). If the port is taken,
  check CORS still allows the new origin.

Verify before moving on: health checks green, workers/queues running, the
frontend loads, one test mail actually reaches the catcher.

## 3. Data: decide what to create, and how

Go screen by screen through the change and ask "what must exist for this to
show something meaningful?"

- **Data the feature itself creates** (templates, campaigns, records) →
  create it through the UI. That *is* the test.
- **Data from imports/migrations** → check it landed correctly (counts,
  flags, and the actual stored values — e.g. URLs, not just row counts).
- **Aggregates and history** (statistics, charts, reports, months of
  activity) → a seed script. Nobody can click their way to 6 months of data.
- **Recipients/accounts** → a tiny dedicated list/set using reserved
  domains (`@example.test`), so nothing can reach a real person.

Seed scripts (keep them in the scratchpad, copy into the container to run):

- Guard: refuse to run unless the environment is local.
- Mark everything with an obvious prefix (`[Demo] …`) and make reruns replace
  only those rows.
- Deterministic (fixed random seed) so a rerun rebuilds the same data.
- Production-style images usually lack dev dependencies (factories, faker):
  insert through the DB layer instead.
- Before rerunning, check what else matches the prefix — a rerun must not
  delete records you created by hand later (rename them first, or narrow the
  delete).

See `references/recipes.md` for seed, webhook and permission-check snippets.

## 4. Test in the browser

Use the built-in browser. The user signs in themselves (never type real
passwords; only test values you created or read from project seed files, on a
local host).

How to drive it reliably:

- Prefer `find`, `read_page` and `get_page_text` over screenshots; screenshots
  can lag behind the page. Click by `ref`, not coordinates.
- After every action that writes, confirm it happened: read the network
  request (status, and the **response body of any 4xx/5xx**), then check the
  DB or API. A toast is not proof.
- Native `window.confirm` dialogs are auto-dismissed in the pane: stub it to
  return true for that one click, record the message, then restore it.
- Drag-and-drop libraries (dnd-kit etc.) often ignore synthetic drags; try the
  keyboard (focus, Space, arrows, Space) before calling it broken.
- Downloads: hook the anchor click to capture name, size and content instead
  of saving files.
- Before any destructive click (delete, archive, send), confirm the target:
  read the row's text from the exact element you're about to click. Scope
  selectors to that row, not a container that holds every row.

What to cover — build this list from the diff, not from the happy path:

1. The main flow end to end, including side effects (the mail arrives, with
   personalisation filled in; the job finishes; the status changes).
2. Every new page and editor: load, edit, save, and the server's response.
3. Filters, views and toggles: check the numbers against a direct DB query.
   Exact matches, not "looks right".
4. External events (webhooks): if the endpoint verifies real signatures,
   dispatch the same job/handler it queues instead, and say so.
5. Permissions: a restricted role through the API (403s where expected), and
   the UI's disabled/hidden states.
6. Each translated/RTL language the app supports: direction, and any leftover
   untranslated strings.
7. Removed features: old routes/menus are gone and nothing still calls them.
8. The project's own checks: format, lint, unit tests, build (in the
   background, from the start).

When something fails, find out why before reporting it: read the response
body, trace the value back to where it was stored or configured, and check
whether it's new in this change (`git merge-base --is-ancestor <commit>
origin/main`) or pre-existing.

## 5. Clean up what you changed

Keep a running list of every state change: branches switched, settings
changed, users/roles created, rows seeded, toggles flipped. Put back what
you only changed to test (switch an email back off, undo a block); leave seeded
data in place unless asked, and list it.

## 6. Report

Use `references/report-template.md`. The essentials:

- One-line verdict first: works / works with issues / blocked.
- Findings grouped by **where the fix belongs**: this change, a dependency's
  branch, environment/setup, or pre-existing. Each with steps to reproduce,
  root cause, and the smallest fix.
- What passed, briefly, with the evidence (counts matched, mail arrived).
- **Not covered**, explicitly. An honest gap list is part of the result.
- Local state you changed.

If the user asks for an MR comment, draft it for them to post; don't post it
yourself. If they bring a code review, check each finding against the code and
say how it compares with what the browser testing did and didn't exercise.
