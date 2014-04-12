#!/bin/bash

# Installs the dotfiles to the home directory
# Note this is untested

git clone git@github.com:gilday/dotfiles.git

ln -s dotfiles/osx/bash_profile .bash_profile
ln -s dotfiles/bash_aliases .bash_aliases
ln -s dotfiles/ackrc .ackrc
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/gitconfig .gitconfig
ln -s ~/dotfiles/osx/inputrc ~/.inputrc

mkdir -p .vim/autoload
cp dotfiles/autoload/pathogen.vim .vim/autoload/

./dotfiles/update_bundles
