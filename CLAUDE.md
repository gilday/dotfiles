# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Code Formatting

Follow the formatting rules defined in `.editorconfig`:
- Use LF line endings for all files
- Ensure all files end with a newline
- Use tabs for indentation in gitconfig files
- For other files, follow existing indentation patterns

## Claude Code Limitations

**Important:** The provisioning playbook requires interactive password prompts that cannot be handled in Claude Code's environment. When assisting with provisioning:
1. Make necessary edits to the playbook files
2. Run `just check` to confirm ansible-lint (strict mode) and syntax check still pass; fix any violations before handing back to the user
3. Prompt the user to run `ansible-playbook provision.yml` in their terminal
4. Review any errors the user reports and make corrections
5. Do NOT attempt to run the playbook directly from Claude Code

## "Update a Claude setting" means this repo

When the user asks to update, change, or add a Claude Code setting, edit the files under `claude/` in this dotfiles repo: typically `claude/managed-settings.yml.j2` (merged into `~/.claude/settings.json` by `claude/claude.yml`), and occasionally `claude/claude.yml` itself. Do NOT edit `~/.claude/settings.json` directly: the auto-mode classifier treats it as self-modification of agent config and the playbook will overwrite hand edits on the next run. After editing, prompt the user to run `just provision` to apply.

## Worktrees: this repo is the exception

This repo is exempt from the global "always use a worktree" default that applies elsewhere. Worktrees isolate the git working copy, but `ansible-playbook` mutates the **target machine**: `~/.gitconfig` and related symlinks, LaunchAgents, Keychain entries, Oh My Zsh custom files under `~/.oh-my-zsh/custom/`, Homebrew installs, and so on. That host state is shared by all worktrees, the main checkout, and every other Claude Code agent on this machine. There is no isolation between agents at the host layer.

When `ansible-playbook` runs from a worktree, `playbook_dir` resolves to the worktree path, and every symlink the playbook installs points into `.../.worktrees/<branch>/...`. Removing the worktree later breaks those symlinks and corrupts the host setup for every shell on the machine, not just the one that ran the playbook.

Work directly on a feature branch in the main checkout. To coordinate multiple changes in flight, use branches plus stash or temporary commits, not worktrees.

## Commands

```bash
# Install collection dependencies (required before first run)
ansible-galaxy collection install -r requirements.yml

# Basic provisioning
ansible-playbook provision.yml

# With sudo access (required for Java, some Homebrew casks)
ansible-playbook provision.yml --ask-become-pass

# Run a specific module
ansible-playbook provision.yml --tags git

# Lint and syntax check
just check
```

## Architecture

This is a dotfiles repository using Ansible for configuration management:

- **Main playbook**: `provision.yml` orchestrates all configuration tasks
- **Module structure**: Each tool has its own directory with:
  - `<module>.yml`: Ansible playbook
  - Configuration files (e.g., `.vimrc`, `.gitconfig`)
  - Optional `.zsh` files for shell configuration
- **Linking strategy**: Files are symlinked with `force: true` for live editing
- **Homebrew**: Guard `homebrew` and `homebrew_cask` tasks with `when: is_macos` (Homebrew is untested on non-macOS)

## Module Organization & Dependencies

`provision.yml` is the authoritative source for module order. The high-level dependencies:

1. `/core`: Base directories (`~/bin`, `~/devtools`), `ackrc`/`screenrc` symlinks, dircolors
2. `/ssh`: SSH config (`~/.ssh/config`, `config.d/`, `allowed_signers`)
3. `/zsh`: Oh My Zsh installation (must run before modules that drop files in `~/.oh-my-zsh/custom`)
4. Remaining modules (see `provision.yml` for exact order):
   - `/git`, `/git-identity`: Git config with SSH commit signing and conditional work/personal includes
   - `/vim`: Vim with vim-plug package manager
   - `/python`, `/node`, `/ruby`, `/java`: Language environments (Java requires admin password for Temurin casks)
   - `/aws`: AWS CLI, ECR credential helper, SSM SSH proxy
   - `/github`: `gh` CLI and Codespaces SSH config
   - `/1password`: CLI and SSH agent integration
   - `/macos`: macOS-specific settings, dark mode, Homebrew packages
   - `/docuum`: Docker image cache cleanup LaunchAgent
   - `/ghostty`, `/vscode`, `/just`: Editor and terminal config
   - `/claude`: Claude Code SSH signing identity and managed settings

## Post-Provisioning Manual Steps

1. **Vim plugins**: Run `:PlugInstall` in vim
2. **ECR Docker config**: Add credential helpers to `~/.docker/config.json`:
   ```json
   {
     "credHelpers": {
       "public.ecr.aws": "ecr-login",
       "<account>.dkr.ecr.<region>.amazonaws.com": "ecr-login"
     }
   }
   ```
3. **1Password SSH**: Configure agent TOML and ensure signing key in `gitconfig` matches a 1Password vault key

## Key Features

- Cross-platform (macOS primary, Linux secondary)
- Dark mode sync across Ghostty, Vim, IntelliJ (⌘⇧L)
- Modular SSH config (`~/.ssh/config.d/`)
- Git SSH commit signing via 1Password
- Homebrew package automation
- Oh My Zsh with Dracula theme