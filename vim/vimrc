""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn on line numbers
set number

"Always show current position
set ruler

"The commandbar height
set cmdheight=2

" Set backspace config
set backspace=eol,start,indent

"Ignore case when searching
set ignorecase
set smartcase

"Highlight search terms
set hlsearch
"Make search act like search in modern browsers
set incsearch

"Show matching bracets when text indicator is over them
set showmatch
"How many tenths of a second to blink
set matchtime=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Theme
set termguicolors
set background=dark
colorscheme solarized8

" SyncDarkMode function detects if the environment is using dark mode and
" configures vim to match. Schedule the function to run periodically to keep
" vim's colors in sync with the environment
function! SyncDarkMode(...)
    let s:new_bg = "dark"
    if $TERM_PROGRAM ==? "iTerm.app"
        let s:mode = trim(system("defaults read -g AppleInterfaceStyle"))
        if s:mode ==? "Dark"
            let s:new_bg = "dark"
        else
            let s:new_bg = "light"
        endif
    else
        if $VIM_BACKGROUND ==? "dark"
            let s:new_bg = "dark"
        else
            let s:new_bg = "light"
        endif
    endif
    if &background !=? s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SyncDarkMode()
call timer_start(3000, "SyncDarkMode", {"repeat": -1})


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git anyway...
set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=8

" golang and make uses tabs instead of spaces
autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8
autocmd FileType make setlocal noexpandtab tabstop=8 shiftwidth=8

" set text wrap for markdown
autocmd FileType markdown setlocal textwidth=80
autocmd FileType md setlocal textwidth=80

"Wrap lines
set wrap


"""""""""""""""""""""""""""""
" => Allow saving of files as sudo when I forgot to start vim using sudo.
"""""""""""""""""""""""""""""
cmap w!! %!sudo tee > /dev/null %


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <silent> <leader><cr> :noh<cr>

" Fast way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => CONFIGURE FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=/usr/local/opt/fzf
map <leader>t :GFiles<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PRETTIER
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
" vim-prettier does not use prettier defaults, correct this insanity
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'none'
autocmd BufWritePre *.ts PrettierAsync


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format JSON with python's JSON module
function! FormatJSON() 
    :%!python -m json.tool 
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TEST
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add typescript to jest pattern
let test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|test))\.(js|jsx|coffee|ts)$'
let test#python#runner = 'nose'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PROJECT SPECIFIC SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable project specific settings (like spaces and tabs) but do not allow
" project specific vimrc files to do unsafe things
" http://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc
set secure
