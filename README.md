# gilday dotfiles

configures my shell to be awesome. supports OS X Mavericks, Cygwin, and Ubuntu. CentOS in progress

## Mac

First, install git and its bash-completion from Homebrew to get the git bash prompt and tab completion to work

    brew install git bash-completion

## Cygwin

Install Cygwin with Git and Ruby packages at the least. Install KDiff3 for windows

## Install

    ./install.sh
    ./install-bundles.sh

Configure git user and email by adding `$HOME/.gitconfig-hook` i.e.

    [user]
        name = Johnathan Gilday
        email = johnathan.gilday@example.com
