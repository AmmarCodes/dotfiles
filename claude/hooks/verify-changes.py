#!/usr/bin/env python3
"""Stop hook: lint, format-check and type-check files changed during this session.

Blocks the turn once with the failures. If the same files still fail on the
next stop, lets the turn end and shows a warning instead of looping.
"""
import hashlib
import json
import os
import subprocess
import sys
from datetime import datetime

JS_EXT = {".js", ".jsx", ".ts", ".tsx", ".mjs", ".cjs", ".vue"}
TS_EXT = {".ts", ".tsx", ".vue"}
PRETTIER_EXT = JS_EXT | {".css", ".scss", ".json", ".md", ".html", ".yaml", ".yml"}
SKIP_DIRS = ("node_modules/", "vendor/", "dist/", "build/", ".next/")
STATE_DIR = os.path.expanduser("~/.claude/hooks/state")
COMMAND_TIMEOUT = 180
MAX_OUTPUT = 1500


def run(cmd, cwd):
    try:
        p = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=COMMAND_TIMEOUT)
        return p.returncode, (p.stdout + p.stderr).strip()
    except subprocess.TimeoutExpired:
        return 0, ""
    except FileNotFoundError as e:
        return 0, str(e)


def git(args, cwd):
    return subprocess.run(["git", *args], cwd=cwd, capture_output=True, text=True).stdout


def session_start(transcript_path):
    try:
        with open(transcript_path) as f:
            for line in f:
                ts = json.loads(line).get("timestamp")
                if ts:
                    return datetime.fromisoformat(ts.replace("Z", "+00:00")).timestamp()
    except (OSError, ValueError):
        pass
    return None


def find_repos(cwd):
    top = git(["rev-parse", "--show-toplevel"], cwd).strip()
    if top:
        return [top]
    repos = []
    for root, dirs, _ in os.walk(cwd):
        depth = root[len(cwd):].count(os.sep)
        if ".git" in dirs:
            repos.append(root)
            dirs[:] = []
        elif depth >= 3:
            dirs[:] = []
        else:
            dirs[:] = [d for d in dirs if d not in ("node_modules", "vendor", ".git")]
    return repos


def changed_files(repo, since):
    out = git(["status", "--porcelain", "--untracked-files=all"], repo)
    files = []
    for line in out.splitlines():
        path = line[3:].split(" -> ")[-1].strip('"')
        full = os.path.join(repo, path)
        if any(s in path for s in SKIP_DIRS) or not os.path.isfile(full):
            continue
        if since is None or os.path.getmtime(full) >= since:
            files.append(path)
    return files


def package_manager(repo):
    if os.path.exists(os.path.join(repo, "pnpm-lock.yaml")):
        return "pnpm"
    if os.path.exists(os.path.join(repo, "yarn.lock")):
        return "yarn"
    return "npm"


def checks_for(repo, files):
    bin_dir = os.path.join(repo, "node_modules", ".bin")
    exts = {os.path.splitext(f)[1] for f in files}
    js = [f for f in files if os.path.splitext(f)[1] in JS_EXT]
    php = [f for f in files if f.endswith(".php")]
    pretty = [f for f in files if os.path.splitext(f)[1] in PRETTIER_EXT]
    checks = []

    if js and os.path.exists(os.path.join(bin_dir, "eslint")):
        checks.append(("eslint", [os.path.join(bin_dir, "eslint"), *js]))
    if pretty and os.path.exists(os.path.join(bin_dir, "prettier")):
        checks.append(("prettier", [os.path.join(bin_dir, "prettier"), "--check", "--ignore-unknown", *pretty]))
    if exts & TS_EXT:
        scripts = {}
        try:
            scripts = json.load(open(os.path.join(repo, "package.json"))).get("scripts", {})
        except (OSError, ValueError):
            pass
        script = next((s for s in ("typecheck", "type-check", "types") if s in scripts), None)
        if script:
            checks.append(("typecheck", [package_manager(repo), "run", "-s", script]))
        elif os.path.exists(os.path.join(repo, "tsconfig.json")) and os.path.exists(os.path.join(bin_dir, "tsc")):
            checks.append(("tsc", [os.path.join(bin_dir, "tsc"), "--noEmit", "-p", "."]))
    for f in php:
        checks.append((f"php -l {f}", ["php", "-l", f]))
    if php and os.path.exists(os.path.join(repo, "vendor/bin/pint")):
        checks.append(("pint", ["vendor/bin/pint", "--test", *php]))
    if php and os.path.exists(os.path.join(repo, "vendor/bin/phpstan")):
        checks.append(("phpstan", ["vendor/bin/phpstan", "analyse", "--no-progress", "--memory-limit=1G", *php]))
    return checks


def fingerprint(repo, files):
    h = hashlib.sha256()
    for f in sorted(files):
        h.update(f.encode())
        with open(os.path.join(repo, f), "rb") as fh:
            h.update(fh.read())
    return h.hexdigest()


def main():
    data = json.load(sys.stdin)
    cwd = data.get("cwd") or os.getcwd()
    since = session_start(data.get("transcript_path", ""))
    state_path = os.path.join(STATE_DIR, f"{data.get('session_id', 'none')}.json")
    os.makedirs(STATE_DIR, exist_ok=True)
    try:
        state = json.load(open(state_path))
    except (OSError, ValueError):
        state = {}

    failures, repeated = [], []
    for repo in find_repos(cwd):
        files = changed_files(repo, since)
        if not files:
            continue
        key = fingerprint(repo, files)
        previous = state.get(repo)
        if previous and previous["key"] == key and previous["ok"]:
            continue
        repo_failures = []
        for name, cmd in checks_for(repo, files):
            code, out = run(cmd, repo)
            # Larastan crashes when the app can't boot locally; only count real findings.
            if name == "phpstan" and "[ERROR] Found" not in out:
                continue
            if code != 0:
                repo_failures.append(f"[{name}]\n{out[-MAX_OUTPUT:]}")
        state[repo] = {"key": key, "ok": not repo_failures}
        if repo_failures:
            report = f"## {repo}\n" + "\n\n".join(repo_failures)
            same_as_before = previous and previous["key"] == key and not previous["ok"]
            (repeated if same_as_before or data.get("stop_hook_active") else failures).append(report)

    json.dump(state, open(state_path, "w"))
    if failures:
        print(json.dumps({
            "decision": "block",
            "reason": "Checks failed on files changed this session. Fix them, or if a failure "
                      "was already there before this session, say so and stop.\n\n" + "\n\n".join(failures),
        }))
    elif repeated:
        names = ", ".join(r.splitlines()[0][3:] for r in repeated)
        print(json.dumps({"systemMessage": f"Checks still failing in {names}; not blocking again."}))


if __name__ == "__main__":
    main()
