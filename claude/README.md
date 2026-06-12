# Claude Code

Setup for unattended Claude Code workflows. For mechanics, read
`claude/claude.yml` and `claude/managed-settings.yml.j2`.

## Why an agent identity exists

My personal SSH key (1Password, Touch ID) is the right protection for
"actually me" actions, but the biometric blocks anything unattended:
overnight runs, AFK sessions, long idle tasks. Claude Code gets its own
SSH key so it can sign commits and push without a fingerprint, while
staying clearly distinct from me.

## Properties

- **Same key signs and authenticates.** Registered on GitHub as both a
  signing key and an authentication key. Leak blast radius: forged
  commits *and* push access on repos I touch. Bounded by independent
  revocation.
- **Independently revocable.** Separate 1Password item, separate GitHub
  registration. Rotating it doesn't touch my personal identity.
- **Claude-only.** Interactive shells keep using the personal key.
  Claude Code subprocesses pick up an alternate `SSH_AUTH_SOCK` and
  `GIT_CONFIG_GLOBAL` via `~/.claude/settings.json`: selection is by
  *what is running git*, not by repo or branch.
- **Private key never on disk.** `op read` pipes it straight into
  `ssh-add -` over stdin.
- **Visibly distinct in history.** `git log --show-signature` shows the
  agent identity, not mine.

## Connecting to servers

Claude offers its own agent key first; falling back to my 1Password key
(Touch ID) is a deliberate, gated escalation.

- **Primary, no Touch ID.** `ssh <host>` works as-is. The catch: the
  1Password-generated blocks in `~/.ssh/1Password/config` pin
  `IdentitiesOnly yes` per host, which tells ssh to ignore every agent
  key except the pinned 1Password identity, including Claude's. So
  `ssh/claude-agent.conf` (deployed to `~/.ssh/config.d/00-claude-agent.conf`)
  flips `IdentitiesOnly no` *only* when the Claude agent is active. It
  sorts ahead of the 1Password include, and ssh takes the first value,
  so it wins. Human sessions are untouched.
- **Trust is per-server.** Add the "Claude Code" pubkey to a server's
  `authorized_keys` and Claude logs in unattended. Omit it and the
  primary attempt fails: `claude-agent.sock` holds only Claude's key and
  cannot present any 1Password key.
- **Fallback, Touch ID.** For a server Claude isn't trusted on, escalate
  explicitly to the 1Password agent. This prompts for a fingerprint and
  acts as the access check:

  ```sh
  ssh -o IdentityAgent="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" <host>
  ```

## What's where

- `claude/`: Ansible playbook, managed settings, LaunchAgent plist, and
  the gitconfig overlay that flips signing config when Claude is the
  caller.
- `ssh/allowed_signers`: agent pubkey alongside the personal one so
  `git log --show-signature` resolves locally.
