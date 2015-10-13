#!/bin/bash

# http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
# Establishes a package manager like system for updating Vim bundles 
#  git://github.com/Lokaltog/vim-powerline.git
# from Github using Pathogen

git_bundles=("tpope/vim-markdown" "vim-ruby/vim-ruby" "pangloss/vim-javascript" "groenewege/vim-less" "altercation/vim-colors-solarized" "scrooloose/syntastic" "fatih/vim-go")

dir="$(dirname $0)/bundle"
rm -rf ${dir}
mkdir -p ${dir}
cd ${dir}
for repo in "${git_bundles[@]}"; do
    echo "git://github.com/${repo}.git"
    `git clone -q git://github.com/${repo}.git`
done    

find -type d -name ".git" -exec rm -rf {} + 

