#!/bin/bash

# Environment support
cygwin=false;
macos=false;
env='linux';
case "`uname`" in 
    CYGWIN*) cygwin=true; env='cygwin' ;;
    Darwin*) macos=true; env='macos' ;;
esac

echo "Install for $env"

# Link dotfiles to $HOME
# pick environment specific override if it exists
# allow an optional second parameter - the "dot directory"
# if the "dot directory" is present, the link will be "HOME/.directory/file"
# if the "dot directory" is NOT present, the link will be "HOME/.file"
link() {
    dotfiles="$HOME/dotfiles"
    if [ $# -gt 1 ]; then
        mkdir -p "$HOME/$2"
        link="$HOME/.$2/$1"
    else
        link="$HOME/.$1"
    fi
    if [ ! -e "$link" ]; then
        if [ -e "$dotfiles/$env/$1" ]; then
            ln -s "$dotfiles/$env/$1" "$link"
        elif [ -e "$dotfiles/$1" ]; then
            ln -s "$dotfiles/$1" "$link"
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
link 'screenrc'
link 'gradle.properties' 'gradle'

echo 'Set color scheme'
if [ ! -e "$HOME/.dircolors" ]; then
    git clone -q git://github.com/seebi/dircolors-solarized "$HOME/dotfiles/packages/dircolors-solarized"
    ln -s "$HOME/dotfiles/packages/dircolors-solarized/dircolors.ansi-dark" "$HOME/.dircolors"
fi
if $centos && [ ! -e "$HOME/dotfiles/packages/gnome-terminal-colors-solarized" ]; then
    git clone -q git://github.com/Anthony25/gnome-terminal-colors-solarized "$HOME/dotfiles/packages/gnome-terminal-colors-solarized"
    echo 'installing shell colors. answer prompts to install colors to gnome terminal profile'
    $HOME/dotfiles/packages/gnome-terminal-colors-solarized/install.sh
fi
if $cygwin && [ ! -e "$HOME/.minttyrc" ]; then
    git clone -q git://github.com/karlin/mintty-colors-solarized "$HOME/dotfiles/packages/mintty-colors-solarized"
    ln -s "$HOME/dotfiles/packages/mintty-colors-solarized/.minttyrc--solarized-dark" "$HOME/.minttyrc"
fi
if [ $(command -v dircolors &> /dev/null) ]; then
    eval `dircolors ~/.dircolors`
fi

echo 'install vim pathogen'
mkdir -p "$HOME/.vim/autoload"
cp "$HOME/dotfiles/autoload/pathogen.vim" "$HOME/.vim/autoload/"
if [ ! -e "$HOME/.vim/bundle" ]; then
    ln -s "$dotfiles/bundle" "$HOME/.vim/bundle"
fi

echo 'install imgls imgcat'
mkdir -p "$HOME/bin"
curl -o "$HOME/bin/imgcat" https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgcat
curl -o "$HOME/bin/imgls" https://raw.githubusercontent.com/gnachman/iTerm2/master/tests/imgls
chmod ug+rx "$HOME/bin/imgcat" "$HOME/bin/imgls"

if $macos; then
    echo 'install iTerm shell integration'
    curl -L https://iterm2.com/misc/`basename $SHELL`_startup.in -o ~/.iterm2_shell_integration.`basename $SHELL`
    echo 'install toggle-dark-mode automator service'
    ln -s $HOME/dotfiles/macos/toggle-dark-mode.workflow $HOME/Library/Services/toggle-dark-mode.workflow
fi

#$HOME/dotfiles/install-bundles.sh

