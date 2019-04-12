#!/bin/bash

# http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen
# Establishes a package manager like system for updating Vim bundles 
#  git://github.com/Lokaltog/vim-powerline.git
# from Github using Pathogen

git_bundles=(
"janko-m/vim-test"
"tpope/vim-markdown"
"vim-ruby/vim-ruby"
"pangloss/vim-javascript"
"mxw/vim-jsx"
"ianks/vim-tsx"
"leafgarland/typescript-vim"
"Quramy/tsuquyomi"
"prettier/vim-prettier"
"groenewege/vim-less"
"altercation/vim-colors-solarized"
"scrooloose/syntastic"
"fatih/vim-go"
"tpope/vim-git"
"mtscout6/syntastic-local-eslint.vim"
"gilday/syntastic-local-standard.vim"
"othree/html5.vim"
"lambdatoast/elm.vim"
"editorconfig/editorconfig-vim"
"scrooloose/nerdtree"
"junegunn/fzf"
"junegunn/fzf.vim"
"tpope/vim-commentary"
"tpope/vim-fugitive"
)

dir="$(dirname $0)/bundle"
rm -rf ${dir}
mkdir -p ${dir}
cd ${dir}
for repo in "${git_bundles[@]}"; do
    echo "git://github.com/${repo}.git"
    `git clone -q git://github.com/${repo}.git`
done    

find . -type d -name ".git" -exec rm -rf {} +

