"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

let g:vim_bootstrap_langs = "php"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
let g:vim_bootstrap_theme = "gruvbox"
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'
Plug 'vim-airline/vim-airline'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" Required:
filetype plugin indent on

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number

let no_buffers_menu=1
colorscheme catppuccin_mocha

" Better command line completion 
set wildmenu

" mouse support
set mouse=a

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10


"*****************************************************************************
"" Keybinds
"*****************************************************************************

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>o :NERDTreeFocus<CR>

" Window
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w!<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>

" Buffer
noremap <leader>c :bd<CR>

" Split
nnoremap <leader>sh :<C-u>split<CR>
nnoremap <leader>sv :<C-u>vsplit<CR>

" Terminal
nnoremap <leader>tf :FloatermNew<CR>
nnoremap <leader>tt :FloatermToggle<CR>
nnoremap <leader>tn :FloatermNext<CR>
nnoremap <leader>tp :FloatermPrev<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
"" Plugin Configurations
"*****************************************************************************

" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/

"*****************************************************************************
"" Language Configurations
"*****************************************************************************

"" C/Cpp
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

"" php
autocmd FileType php setlocal tabstop=2 shiftwidth=2 expandtab

"" js
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 expandtab
