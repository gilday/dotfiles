# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Setup/Installation:**
```bash
ansible-playbook provision.yml
```

**Configuration Management:**
- Main configuration file: `provision.yml` (Ansible playbook)
- Manages dotfiles linking and tool installation across macOS and Linux
- Creates symbolic links from dotfiles directory to canonical locations in `$HOME`

## Architecture

This is a dotfiles repository using Ansible for configuration management. The architecture follows a modular design:

**Core Structure:**
- `provision.yml`: Main playbook that orchestrates all configuration tasks
- Each tool/service has its own directory with `.yml` playbook and config files
- Symlinks are created from dotfiles to canonical locations (`~/.gitconfig`, `~/.vimrc`, etc.)

**Module Organization:**
- `/core`: Base system configuration, SSH, and essential tools
- `/zsh`: Shell configuration with Oh My Zsh, custom theme, and plugins
- `/git`: Git configuration with gitmoji support
- `/vim`: Vim/Neovim configuration with vim-plug
- `/macos`: macOS-specific settings, dark mode toggle, and Homebrew packages
- `/vscode`: VS Code configuration and extensions
- `/aws`, `/java`, `/node`, `/python`, `/ruby`: Language and tool-specific configurations
- `/1password`: 1Password CLI and SSH agent integration
- `/bin`: Custom utility scripts (echo-server.py, tcp-proxy.sh, ancestor.rb)

**Key Features:**
- Cross-platform support (macOS primary, Linux secondary)
- Dark mode synchronization across iTerm2, Vim, and IntelliJ
- SSH configuration with modular include system (`~/.ssh/config.d/`)
- Automated Homebrew package management
- Oh My Zsh with Dracula theme and autosuggestions

**Linking Strategy:**
Most configuration files are symlinked rather than copied, allowing direct editing of files in the repository with immediate effect in the system.
