# claude

Personal [Claude Code](https://claude.ai/code) configuration — tracked so it's portable across machines. Lives at `~/.claude`, which is Claude Code's default config directory.

## What's here

- `settings.json` — model, statusline, plugins, effort level
- `keybindings.json` — keybinding overrides to avoid conflicts with bash vi-mode, tmux, and standard terminal shortcuts
- `statusline-command.sh` — bash script rendering `[user@cwd]` in the statusline
- `settings.local.json.example` — template for per-machine permissions (the real `settings.local.json` is gitignored)

## Setup on a new machine

```bash
git clone https://github.com/LoganGeldenhuys/claude.git ~/.claude
cp ~/.claude/settings.local.json.example ~/.claude/settings.local.json
chmod +x ~/.claude/statusline-command.sh
```

Runtime files (credentials, history, sessions, memory, etc.) are created by Claude Code on first run and are all gitignored.

See [CLAUDE.md](CLAUDE.md) for the full file-by-file breakdown and the portability pattern.
