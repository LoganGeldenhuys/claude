# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Claude Code configuration tracked in git. Lives at `~/.claude`, which is Claude Code's default config directory — files are read from here directly, no symlinking required.

## File Structure

| File | Tracked | Purpose |
|------|---------|---------|
| `settings.json` | Yes | Model, statusline, enabled plugins, effort level |
| `keybindings.json` | Yes | Global + Chat keybinding overrides |
| `statusline-command.sh` | Yes | Bash script rendering the statusline (`[user@cwd]`) |
| `settings.local.json.example` | Yes | Template for per-machine permissions |
| `settings.local.json` | No (gitignored) | Actual per-machine permissions allowlist |
| `.credentials.json` | No (gitignored) | Auth tokens |
| `history.jsonl`, `sessions/`, `memory/`, `projects/`, `plans/`, etc. | No (gitignored) | Runtime state |

## Setup on a New Machine

```bash
# 1. Clone into ~/.claude (must be empty or non-existent)
git clone https://github.com/LoganGeldenhuys/claude.git ~/.claude

# 2. Seed per-machine permissions from the template
cp ~/.claude/settings.local.json.example ~/.claude/settings.local.json
# Edit settings.local.json and add any machine-specific permission allowlist entries

# 3. Make the statusline script executable
chmod +x ~/.claude/statusline-command.sh
```

Runtime files (`.credentials.json`, `history.jsonl`, `sessions/`, etc.) are created automatically by Claude Code on first run — nothing to set up by hand.

## Architecture

- **`settings.json`** — declares the model (`opus`), wires up the statusline command, enables language-server plugins, and sets the default effort level. No machine-specific paths.
- **`keybindings.json`** — overrides a handful of default bindings to resolve conflicts with bash vi-mode, tmux-navigator, and standard terminal shortcuts (`ctrl+l`, `ctrl+t`, `ctrl+o`, `ctrl+s`, `ctrl+v`). Moves the clobbered actions onto `ctrl+k` chord prefixes.
- **`statusline-command.sh`** — reads JSON on stdin, pulls out `cwd`, and prints `[user@basename]` in bold white. Called by `settings.json`'s `statusLine.command`.
- **`settings.local.json`** (gitignored) — per-machine `permissions.allow` entries: things like project-specific `Bash(...)` patterns, MCP tool allowlists, or `WebFetch` domains. Never committed.

## Portability Pattern

Tracked files deliberately avoid anything machine-specific:

- `statusline-command.sh` uses only `jq`, `basename`, and `whoami` — all universally available.
- `settings.json` and `keybindings.json` are pure JSON with no absolute paths.
- Anything per-machine lives in `settings.local.json` (gitignored) and is templated by `settings.local.json.example`.

This mirrors the pattern used in the companion bash config repo (`LoganGeldenhuys/bash`): tracked portable core, gitignored `*.local` override, `*.example` template.

## What Goes in `settings.local.json`

Put these in the gitignored `settings.local.json`, not `settings.json`:

- `Bash(...)` permission allowlist entries for specific tools or repos
- MCP server tool allowlists
- `WebFetch(domain:...)` entries for sites you use locally
- Anything that varies by machine, project, or personal workflow
