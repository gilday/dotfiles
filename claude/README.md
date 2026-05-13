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

## What's where

- `claude/`: Ansible playbook, managed settings, LaunchAgent plist, and
  the gitconfig overlay that flips signing config when Claude is the
  caller.
- `ssh/allowed_signers`: agent pubkey alongside the personal one so
  `git log --show-signature` resolves locally.
