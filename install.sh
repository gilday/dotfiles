#!/bin/bash

# Installs the dotfiles to the home directory
cd $HOME
if [ ! -d $HOME/dotfiles ] ; then
  git clone git@github.com:gilday/dotfiles.git
fi

ln -s dotfiles/bashrc .bashrc
ln -s dotfiles/bash_aliases .bash_aliases
ln -s dotfiles/ackrc .ackrc
ln -s dotfiles/vimrc .vimrc
ln -s dotfiles/gitconfig .gitconfig
ln -s dotfiles/osx/inputrc .inputrc

mkdir -p .vim/autoload
cp dotfiles/autoload/pathogen.vim .vim/autoload/

./dotfiles/update_bundles
