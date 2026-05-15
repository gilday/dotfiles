#!/bin/bash
# SessionStart hook: source $PWD/.env into the agent's session environment.
#
# Why: the oh-my-zsh dotenv plugin only fires on shell chpwd, so it loads
# per-repo .env files when the user cd's in a terminal. Agents spawned from
# the Claude Code agent view start with cwd already set to the repo dir;
# no chpwd ever fires, so the .env is never sourced and secrets are missing.
#
# How to apply: Claude Code passes CLAUDE_ENV_FILE, an append-only file that
# the session sources before any tool call. Appending `set -a; . .env; set +a`
# exports every assignment in .env into the session environment.
set -euo pipefail

[ -n "${CLAUDE_ENV_FILE:-}" ] || exit 0
[ -f "$PWD/.env" ] || exit 0

{
  echo "set -a"
  echo ". \"$PWD/.env\""
  echo "set +a"
} >> "$CLAUDE_ENV_FILE"
