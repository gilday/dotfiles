#!/bin/bash

# Environment support
cygwin=false;
osx=false;
env='linux';
case "`uname`" in 
    CYGWIN*) cygwin=true; env='cygwin' ;;
    Darwin*) osx=true; env='osx' ;;
esac

echo "Install for $env"

# Link dotfiles to $HOME
# pick environment specific overrides if they exist

link() {
    dotfiles="$HOME/dotfiles"
    if [ ! -e "$HOME/.$1" ]; then
        if [ -e "$dotfiles/$env/$1" ]; then
            ln -s "$dotfiles/$env/$1" "$HOME/.$1"
        elif [ -e "$dotfiles/$1" ]; then
            ln -s "$dotfiles/$1" "$HOME/.$1"
        fi
    fi
}

# Installs the dotfiles to the home directory
# this is useful if I want to have one command to download and install the dotfiles repo
cd $HOME
if [ ! -d $HOME/dotfiles ] ; then
  git clone git@github.com:gilday/dotfiles.git
fi


echo 'Link dotfiles'

link 'bashrc'
link 'bash_profile'
link 'bash_aliases'
link 'ackrc'
link 'vimrc'
link 'gitconfig'
link 'inputrc'

if $cygwin && [ ! -e "$HOME/.minttyrc" ]; then
    echo 'Set color scheme'
    git clone -q git://github.com/karlin/mintty-colors-solarized "$HOME/dotfiles/packages/mintty-colors-solarized"
    git clone -q git://github.com/seebi/dircolors-solarized "$HOME/dotfiles/packages/dircolors-solarized"
    ln -s "$HOME/dotfiles/packages/mintty-colors-solarized/.minttyrc--solarized-dark" "$HOME/.minttyrc"
    ln -s "$HOME/dotfiles/packages/dircolors-solarized/dircolors.ansi-dark" "$HOME/.dircolors"
fi
if $cygwin; then
    eval `dircolors ~/.dircolors`
fi

mkdir -p "$HOME/.vim/autoload"
cp "$HOME/dotfiles/autoload/pathogen.vim" "$HOME/.vim/autoload/"

#$HOME/dotfiles/update_bundles


