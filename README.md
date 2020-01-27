# gilday dotfiles

Configures my shell (zsh) to be awesome. I have been developing exclusively on a
mac for a couple of years, so it leans heavily towards macOS. Next time I
develop on a Linux desktop, I will update support for that system. I removed
support for Cygwin: I have not developed on Windows in a while, and I expect to
make use of the new Windows Subsystem for Linux next time I do.


## Install

Install Ansible, then run the provision.yml playbook

    ansible-playbook provision.yml

Configure git user and email by adding `$HOME/.gitconfig-hook` i.e.

    [user]
        name = Johnathan Gilday
        email = me@johnathangilday.com


### macOS Dark Mode Toggle

macOS Mojave introduced "Dark Mode", but applications which have their own Dark
mode features are not yet integrated with this feature. I need scripts and
keyboard shortcuts to glue all the "Dark Modes" together. Inspired by
https://stefan.sofa-rockers.org/2018/10/23/macos-dark-mode-terminal-vim/

The Automator Quick Action service
[toggle-dark-mode.workflow](./macos/toggle-dark-mode.workflow) toggles the macOS
Dark Mode, then runs an Apple Script to update iTerm's color scheme.

A scheduled vim function reads the current environment and updates the vim color
scheme accordingly.

IntelliJ uses the same polling mechanism as vim: the IntelliJ plugin [macOS Dark
Mode Sync](https://plugins.jetbrains.com/plugin/12515-macos-dark-mode-sync)
polls the current system settings and adjusts IntelliJ's theme accordingly.

1. Create keyboard shortcut for the Automator service "toggle-dark-mode"
   (installed by Ansible in previous steps). I use ⌘⇧L
1. Install IntelliJ [macOS Dark Mode
   Sync](https://plugins.jetbrains.com/plugin/12515-macos-dark-mode-sync) plugin
