# Obsidian CLI — Full Command Reference

Complete reference for all official Obsidian CLI commands (v1.12+).

**Syntax**: `obsidian [vault] <command> [subcommand] [key=value ...] [flags]`

All parameters use `key=value` syntax. Quote values containing spaces: `content="hello world"`.

---

## Table of Contents

1. [Files](#files)
2. [Daily Notes](#daily-notes)
3. [Search](#search)
4. [Properties](#properties)
5. [Tags](#tags)
6. [Tasks](#tasks)
7. [Links](#links)
8. [Bookmarks](#bookmarks)
9. [Templates](#templates)
10. [Plugins](#plugins)
11. [Sync](#sync)
12. [Themes](#themes)
13. [CSS Snippets](#css-snippets)
14. [Commands & Hotkeys](#commands--hotkeys)
15. [Obsidian Bases](#obsidian-bases)
16. [History](#history)
17. [Workspace & Tabs](#workspace--tabs)
18. [Diff](#diff)
19. [Developer](#developer)
20. [Vault & System](#vault--system)

---

## Files

File operations: read, write, create, move, delete, list.

### Reading Notes

```bash
obsidian read path="folder/note.md"
```

Prints raw markdown content of a note to stdout. Path is vault-relative.

### Creating Notes

```bash
obsidian create path="folder/note" content="# Title\n\nBody text"
obsidian create path="folder/note" template="template-name"
```

- Path should **not** include `.md` — it is appended automatically.
- Use `template=` to create from a template file.
- Use `content=` to set initial content directly.

### Appending & Prepending

```bash
obsidian append path="folder/note.md" content="Appended text"
obsidian prepend path="folder/note.md" content="Prepended text"
```

- `append` adds content at the end of the file.
- `prepend` adds content after the frontmatter (not at byte 0).

### Moving & Renaming

```bash
obsidian move path="old/path/note.md" to="new/path/note.md"
```

- `to=` is the full vault-relative target path including the `.md` extension.
- Can be used to move, rename, or both in a single command.

### Deleting

```bash
obsidian delete path="folder/note.md"           # Moves to trash
obsidian delete path="folder/note.md" permanent  # Permanent deletion
```

### File Discovery

```bash
obsidian files                       # List all files in vault
obsidian files ext=md                # Filter by extension
obsidian files folder="subfolder"    # Files in specific folder
obsidian files total                 # Just the file count
obsidian folders                     # List all folders
obsidian file path="folder/note.md"  # File info (size, created, modified dates)
```

### Random Notes

```bash
obsidian random           # Open a random note in Obsidian
obsidian random:read      # Print content of a random note to stdout
```

### Renaming

```bash
obsidian rename path="folder/note.md" name="new-name"
```

- `name=` is the new filename only (no path, no `.md` extension).
- Use `move` when you also want to change the folder.

---

## Daily Notes

Operations on the daily note (requires Daily Notes core plugin enabled).

```bash
obsidian daily                           # Open today's daily note in Obsidian
obsidian daily:read                      # Print today's daily note content to stdout
obsidian daily:append content="text"     # Append content to today's note
obsidian daily:prepend content="text"    # Prepend content (after frontmatter)
obsidian daily:path                      # Print vault-relative path of today's note
```

**Notes:**

- `daily:prepend` inserts content after the frontmatter block, not at the very beginning.
- If today's note doesn't exist, `daily` will create it (using the configured template if set).
- Daily note format/folder are configured in Obsidian's Daily Notes plugin settings.

---

## Search

Full-text search across the vault.

```bash
obsidian search query="search text"
obsidian search query="text" path="folder"         # Scope to folder
obsidian search query="text" limit=10               # Limit results
obsidian search query="text" format=json            # JSON output (array of file paths)
obsidian search query="text" matches                # Accepted but returns file paths only
obsidian search query="text" case                   # Case-sensitive search
```

**Parameters:**

- `query=` — Search term (required)
- `path=` — Restrict search to a folder
- `limit=` — Maximum number of results
- `format=json` — Returns a JSON array of matching file paths: `["folder/note.md", ...]`
- `matches` — Flag accepted by the CLI but does not return match context/snippets in v1.12
- `case` — Enable case-sensitive matching

### Search with Context

```bash
obsidian search:context query="search text"
obsidian search:context query="text" path="folder" limit=10
obsidian search:context query="text" case
obsidian search:context query="text" format=json
```

Returns matching lines with surrounding context (not just file paths). Useful when you need to see the actual content that matched rather than just file paths.

### Open Search View

```bash
obsidian search:open query="search text"
```

Opens the Obsidian search panel in the UI with the given query.

---

## Properties

Manage frontmatter (YAML metadata) on notes.

### Read All Properties

```bash
obsidian properties path="note.md"
```

### Read Single Property

```bash
obsidian property:read path="note.md" name="status"
```

### Set Property

```bash
obsidian property:set path="note.md" name="status" value="active"
obsidian property:set path="note.md" name="tags" value="[project, alpha]"
obsidian property:set path="note.md" name="date" value="2026-02-27"
```

> **Note:** `property:set` always stores `value=` as a string. Passing `value="[project, alpha]"` writes
> the literal string `[project, alpha]`, not a YAML array. For true array-typed properties (e.g. `tags`),
> edit the note's frontmatter directly or use `eval` with the Obsidian API.

### Remove Property

```bash
obsidian property:remove path="note.md" name="draft"
```

### Aliases

```bash
obsidian aliases path="note.md"
```

Lists all aliases defined in the note's frontmatter.

---

## Tags

Tag discovery and filtering.

```bash
obsidian tags                          # List all tags in the vault
obsidian tags counts                   # Tags with usage counts
obsidian tags counts sort=count        # Sorted by frequency (most used first)
obsidian tags path="note.md"           # Tags in a specific file
obsidian tag name="project/alpha"      # List notes with a specific tag
```

**Notes:**

- Nested tags are supported (e.g., `project/alpha`).
- Tags from both frontmatter and inline `#tag` syntax are included.

---

## Tasks

Query and manage checkbox tasks across the vault.

### Querying Tasks

```bash
obsidian tasks                         # All tasks (same as tasks all in v1.12)
obsidian tasks all                     # All tasks (complete + incomplete)
obsidian tasks done                    # Only completed tasks
obsidian tasks path="note.md"          # Tasks in a specific file
obsidian tasks daily                   # Tasks in today's daily note
```

> **Note:** In v1.12, `tasks` with no arguments returns all tasks (complete + incomplete), identical to `tasks all`. Filtering to incomplete-only is not currently supported without post-processing (e.g. pipe to `grep "\[ \]"`).

### Toggling Task Status

```bash
obsidian task path="note.md" line=12 toggle
```

Toggles the checkbox on the specified line number between `- [ ]` and `- [x]`.

---

## Links

Graph analysis and link management.

```bash
obsidian backlinks path="note.md"         # Notes linking TO this note
obsidian backlinks path="note.md" counts  # With link counts per file
obsidian links path="note.md"             # Outgoing links FROM this note
obsidian unresolved                        # All unresolved [[wikilinks]]
obsidian orphans                           # Notes with no incoming or outgoing links
obsidian deadends                          # Notes with no outgoing links
```

---

## Bookmarks

Manage Obsidian bookmarks (requires Bookmarks core plugin).

```bash
obsidian bookmarks                                      # List all bookmarks
obsidian bookmark file="folder/note.md"                 # Bookmark a note
obsidian bookmark file="folder/note.md" subpath="#Heading"  # Bookmark a heading
obsidian bookmark folder="projects"                     # Bookmark a folder
obsidian bookmark search="query text" title="My Search" # Bookmark a search
obsidian bookmark url="https://example.com" title="Link" # Bookmark a URL
```

---

## Templates

Work with note templates (requires Templates or Templater plugin).

```bash
obsidian templates                                      # List available templates
obsidian template:read name="weekly-review"             # Read template content
obsidian template:read name="weekly-review" resolve title="My Note"  # Render with variables
obsidian template:insert name="weekly-review"           # Insert template into the active Obsidian UI file
```

**Parameters:**

- `name=` — Template name (without path prefix or extension)
- `resolve` — Process template variables (`{{date}}`, `{{title}}`, etc.)
- Title and other variables can be passed as `key=value` for template rendering.

> **Note:** `template:insert` inserts into whichever file is currently active in the Obsidian UI — it does not accept a `path=` parameter. If no file is open, it returns `Error: No active editor. Open a file first.` To create a new file from a template, use `obsidian create path="..." template="..."` instead.

---

## Plugins

Manage community and core plugins.

```bash
obsidian plugins                         # List all plugins (core + community)
obsidian plugins:enabled                 # Only enabled plugins
obsidian plugins versions                # Plugins with version numbers (community only)
obsidian plugins:restrict                # Show restricted mode status
obsidian plugins:restrict on             # Enable restricted mode (disables community plugins)
obsidian plugins:restrict off            # Disable restricted mode
obsidian plugin id="dataview"            # Get info about a specific plugin
obsidian plugin:enable id="canvas"       # Enable a plugin
obsidian plugin:disable id="canvas"      # Disable a plugin
obsidian plugin:install id="dataview"    # Install from community plugins
obsidian plugin:uninstall id="dataview"  # Uninstall a community plugin
obsidian plugin:reload id="my-plugin"    # Reload a plugin (useful for dev)
```

> **Note:** `plugins versions` only shows version numbers for community plugins. Core (built-in) plugins share Obsidian's version and display blank version fields.

---

## Sync

Manage Obsidian Sync (requires active Sync subscription).

```bash
obsidian sync                                   # Show sync status summary
obsidian sync on                                # Resume syncing
obsidian sync off                               # Pause syncing
obsidian sync:status                            # Detailed sync status
obsidian sync:history path="note.md"            # Version history for a file
obsidian sync:read path="note.md" version=3     # Read a specific version
obsidian sync:restore path="note.md" version=3  # Restore a previous version
obsidian sync:deleted                           # List files deleted via sync
obsidian sync:open                              # Open the Sync history view in the UI
```

---

## Themes

Manage appearance themes.

```bash
obsidian themes                            # List installed themes
obsidian themes versions                   # List installed themes with version numbers
obsidian theme                             # Show the currently active theme
obsidian theme name="Minimal"              # Get details about a specific theme
obsidian theme:set name="Minimal"          # Switch to a theme
obsidian theme:set name=""                 # Switch back to default theme
obsidian theme:install name="Minimal"      # Install a community theme
obsidian theme:install name="Minimal" enable  # Install and activate immediately
obsidian theme:uninstall name="Minimal"    # Uninstall a theme
```

---

## CSS Snippets

Manage custom CSS snippet files (snippets live in `.obsidian/snippets/`).

```bash
obsidian snippets                          # List all installed CSS snippets
obsidian snippets:enabled                  # List only enabled snippets
obsidian snippet:enable name="my-style"    # Enable a snippet
obsidian snippet:disable name="my-style"   # Disable a snippet
```

---

## Commands & Hotkeys

Execute any Obsidian command by its ID, and inspect hotkey bindings.

```bash
obsidian commands                          # List all available command IDs
obsidian command id="app:reload"           # Execute a command by ID
obsidian command id="editor:toggle-bold"   # Example: toggle bold in active editor
obsidian hotkeys                           # List all hotkeys (tab-separated: id \t keybinding)
obsidian hotkey id="app:open-settings"     # Get hotkey for a specific command
obsidian hotkey id="app:open-settings" verbose  # Show if custom or default
```

**Typical workflow — find and run a command:**

```bash
obsidian commands | grep "canvas"          # Find canvas-related command IDs
obsidian command id="canvas:new-file"      # Execute the matched command
```

**Getting plugin command IDs:**

```bash
obsidian commands | grep "dataview"        # List all Dataview plugin commands
```

---

## Obsidian Bases

Obsidian Bases (v1.12+) is a built-in database feature. Base files (`.base`) store structured data and support multiple views.

```bash
obsidian bases                                    # List all .base files in vault
obsidian base:query file="tasks" format=json      # Query default view of a base
obsidian base:query file="tasks" view="Kanban"    # Query a specific view
obsidian base:query path="folder/tasks.base" format=csv  # Query by path
obsidian base:views file="tasks"                  # List all views in a base file
obsidian base:create file="tasks" title="Buy milk"  # Add an item to a base
```

**Supported output formats for `base:query`:** `json` (default), `csv`, `tsv`, `md`, `paths`

---

## History

File version history (built-in to Obsidian, separate from Sync). Requires the File Recovery core plugin.

```bash
obsidian history:list                             # List all files that have history
obsidian history path="folder/note.md"            # List versions of a specific file
obsidian history:read path="folder/note.md"       # Read the latest saved version
obsidian history:read path="folder/note.md" version=3  # Read a specific version
obsidian history:restore path="folder/note.md" version=3  # Restore a version
obsidian history:open path="folder/note.md"       # Open file recovery UI for a file
```

> **Note:** History is distinct from [Sync version history](#sync). History uses Obsidian's built-in File Recovery snapshots; Sync history uses Obsidian Sync cloud versions.

---

## Workspace & Tabs

Inspect and manage the Obsidian workspace layout and open tabs.

```bash
obsidian workspace                                # Show the full workspace tree
obsidian tabs                                     # List all open tabs (flat list)
obsidian tab:open file="folder/note.md"           # Open a file in a new tab
obsidian tab:open view="graph"                    # Open a view type in a new tab
```

---

## Diff

Compare local and sync versions of a file.

```bash
obsidian diff path="folder/note.md"               # List available versions (local + sync)
obsidian diff path="folder/note.md" from=1 to=2   # Diff two specific versions
obsidian diff path="folder/note.md" filter=local  # Show only local versions
obsidian diff path="folder/note.md" filter=sync   # Show only sync versions
```

---

## Developer

Debugging and development tools.

### Screenshots

```bash
obsidian dev:screenshot path="folder/screenshot.png"
```

Takes a screenshot of the Obsidian window and saves it. **Path must be vault-relative** — absolute filesystem paths are silently ignored.

### JavaScript Evaluation

```bash
obsidian eval code="app.vault.getFiles().length"
obsidian eval code="app.vault.getMarkdownFiles().map(f => f.path).join('\n')"
```

Executes arbitrary JavaScript in the Obsidian app context. Has access to the full Obsidian API (`app`, `app.vault`, `app.workspace`, `app.metadataCache`, etc.).

> **Multiline scripts:** Passing multiline JavaScript inline fails with "Invalid or unexpected token".
> Write the code to a temp file and use command substitution instead:
>
> ```bash
> cat > /tmp/obs.js << 'JS'
> var files = app.vault.getMarkdownFiles();
> files.map(f => f.path).join('\n');
> JS
> obsidian eval code="$(cat /tmp/obs.js)"
> ```

### Console & Errors

```bash
obsidian dev:debug on              # Start capturing console output (required before dev:console)
obsidian dev:debug off             # Stop capturing console output
obsidian dev:console limit=20     # Recent console output (requires dev:debug on first)
obsidian dev:errors                # Recent error messages
```

> **Note:** `dev:console` will return an error unless `dev:debug on` has been run first in the current session.

### DOM Inspection

```bash
obsidian dev:dom selector=".view-content"             # Get outerHTML of first match
obsidian dev:dom selector=".view-content" all         # Get all matches
obsidian dev:dom selector=".view-content" text        # Get text content
obsidian dev:dom selector=".view-content" total       # Count matching elements
obsidian dev:dom selector=".view-content" attr=class  # Get an attribute value
obsidian dev:dom selector=".view-content" css=color   # Get a CSS property value
```

### CSS Inspection

```bash
obsidian dev:css selector=".view-content"              # Inspect CSS with source locations
obsidian dev:css selector=".view-content" prop=color   # Filter by CSS property name
```

### Chrome DevTools Protocol

```bash
obsidian devtools                                      # Toggle Electron DevTools panel
obsidian dev:cdp method="Runtime.evaluate" params='{"expression":"1+1"}'  # Run a CDP command
```

### Mobile Emulation

```bash
obsidian dev:mobile on                                 # Enable mobile emulation
obsidian dev:mobile off                                # Disable mobile emulation
```

---

## Vault & System

### Vault Information

```bash
obsidian vault                         # Current vault: name, path, file/folder counts
obsidian vaults                        # List all known vaults
```

### Other Utilities

```bash
obsidian version                       # Obsidian version info
obsidian outline path="note.md"        # Heading structure of a note
obsidian wordcount path="note.md"      # Word and character count
obsidian recents                       # Recently opened files
obsidian reload                        # Reload the vault (re-index)
obsidian restart                       # Restart the Obsidian app
```

---

## Output Formatting & Piping

The CLI outputs plain text by default, ideal for piping into Unix tools.

### Supported `format=` values

| Format  | Description            | Best for                      |
| ------- | ---------------------- | ----------------------------- |
| `text`  | Plain text (default)   | Piping to grep/awk/sed        |
| `json`  | JSON array or object   | Processing with jq, AI agents |
| `csv`   | Comma-separated values | Spreadsheet import            |
| `tsv`   | Tab-separated values   | Shell parsing with cut/awk    |
| `yaml`  | YAML output            | Config-style processing       |
| `md`    | Markdown table         | Embedding results in notes    |
| `paths` | One path per line      | Batch file operations         |
| `tree`  | Tree view              | Visual hierarchy              |

Not all formats are supported by every command. Use `text` or `json` when in doubt.

### Examples

```bash
# Count notes in a folder
obsidian files folder="projects" | wc -l

# Find notes with a specific tag, then read them
obsidian tag name="urgent" | while read -r note; do
  echo "=== $note ==="
  obsidian read path="$note"
done

# Export search results as JSON and process with jq
# format=json returns an array of file path strings: ["folder/note.md", ...]
obsidian search query="meeting" format=json | jq '.[]'

# Query a base as CSV
obsidian base:query file="tasks" format=csv

# Filter console errors (requires dev:debug on first)
obsidian dev:debug on
obsidian dev:console limit=50 | grep -i error
```

---

## Multi-Vault Usage

When working with multiple vaults, pass the vault name as the **first argument** (before the command):

```bash
obsidian "Personal" daily:read
obsidian "Work" search query="standup"
obsidian "Archive" files total
```

If the vault name contains spaces, quote it. The vault name must match what's shown in `obsidian vaults`.

> **Compatibility note:** On some environments, `obsidian "My Vault" command` returns
> `Error: Command "My Vault" not found`. If this occurs, omit the vault name — the CLI will target
> the most recently active vault. Switch vaults in the Obsidian UI before running CLI commands
> when targeting a specific vault.

---

## Headless / Server Setup (Linux)

For running Obsidian CLI on a headless Linux server (useful for AI agent integration):

1. Install the `.deb` package (not snap — snap confinement breaks IPC)
2. Install and start `xvfb`: `Xvfb :5 -screen 0 1920x1080x24 &`
3. Start Obsidian under xvfb: `DISPLAY=:5 obsidian &`
4. Run CLI commands: `DISPLAY=:5 obsidian daily:read`

**Systemd note**: If running as a service, ensure `PrivateTmp=false` so the IPC socket is accessible.

**Stderr filtering**: Headless environments produce harmless GPU warnings. Filter with:

```bash
DISPLAY=:5 obsidian search query="test" 2>/dev/null
```
