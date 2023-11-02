"""""""""""""""""""""""""""""""""""""""
" Vim Config
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Vim-Plug bootstrap
"""""""""""""""""""""""""""""""""""""""
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

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

"""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""
call plug#begin(expand('~/.vim/plugged'))

Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'matze/vim-move'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install --no-dev -o'}
Plug 'stephpy/vim-php-cs-fixer'
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'preservim/nerdcommenter'
Plug 'frazrepo/vim-rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Options
"""""""""""""""""""""""""""""""""""""""
let mapleader = " "

set background=dark
syntax enable
set regexpengine=0
colorscheme catppuccin_mocha
filetype plugin on
filetype indent on
set history=500
set so=7
set wildmenu
set ruler
set ignorecase
set smartcase
set hlsearch
set magic
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap
set switchbuf=useopen,usetab,newtab
set stal=2
set number
set relativenumber
set termguicolors
set cmdheight=1
set shortmess=a
set laststatus=2
set noshowmode
set showmatch
set mat=2
set hlsearch
set incsearch
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set hid
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set hidden
set ttyfast
set gfn=Monospace\ 10
set splitbelow
set splitright
set autoread

"""""""""""""""""""""""""""""""""""""""
" Plugin options
"""""""""""""""""""""""""""""""""""""""

" NERD Tree
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '.git', 'node_modules']
let g:NERDTreeWinSize=35
map <leader>e :NERDTreeToggle<cr>
map <leader>eb :NERDTreeFromBookmark<Space>
map <leader>ef :NERDTreeFind<cr>
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Lightline
let g:lightline = {
    \ 'colorscheme': 'catppuccin_mocha',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['fugitive', 'readonly', 'filename', 'modified'] ],
    \   'right': [ [ 'lineinfo' ], ['percent'] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
    \ },
    \ 'separator': { 'left': ' ', 'right': ' ' },
    \ 'subseparator': { 'left': ' ', 'right': ' ' }
    \ }

" Yank stack
let g:yankstack_yank_keys = ['y', 'd']

nmap <C-p> <Plug>yankstack_substitute_older_paste
nmap <C-n> <Plug>yankstack_substitute_newer_paste

" Vim rainbow
let g:rainbow_active = 1


"""""""""""""""""""""""""""""""""""""""
" Keymaps
"""""""""""""""""""""""""""""""""""""""

" Save and close
nnoremap <leader>w <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>
nnoremap <leader>W <cmd>w!<cr>
nnoremap <leader>Q <cmd>q!<cr>

" W saves files as root
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Disable highlight
map <silent> <leader><cr> <cmd>noh<cr>

" Movement between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close current buffer
map <leader>bd <cmd>Bclose<cr><cmd>tabclose<cr>gT

" Move between buffers
map <leader>l <cmd>bnext<cr>
map <leader>h <cmd>bprevious<cr>

" Reverse tab
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Escape
inoremap jj <Esc>
inoremap jk <Esc>

" Move
vnoremap <S-j> <plug>MoveBlockDown
vnoremap <S-k> <plug>MoveBlockUp
nnoremap <S-j> <plug>MoveLineDown
nnoremap <S-k> <plug>MoveLineUp

" Terminal
map <leader>t <cmd>term ++close<cr>
tmap <leader>t <C-w><cmd>term ++close<cr>

vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a`<esc>`<i`<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" Bash like keys for the command line
cnoremap <C-A>          <Home>
cnoremap <C-E>          <End>
cnoremap <C-K>          <C-U>

" Remap 0 to first non-blank character
map 0 ^

" Useful mappings for managing tabs
map <leader>tn <cmd>tabnew<cr>
map <leader>to <cmd>tabonly<cr>
map <leader>tc <cmd>tabclose<cr>
map <leader>tm <cmd>tabmove
map <leader>t<leader> <cmd>tabnext<cr>

" Create splits
map <leader>sv <cmd>vsplit<cr>
map <leader>sh <cmd>split<cr>

" Comments
nnoremap <leader>/ <plug>CommentaryLine
vnoremap <leader>/ <plug>Commentary

"""""""""""""""""""""""""""""""""""""""
" Languages
"""""""""""""""""""""""""""""""""""""""

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

" javascript
let g:javascript_enable_domhtmlcss = 1
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript setl tabstop=4|setl shiftwidth=4|setl expandtab softtabstop=4
augroup END

" php
" Phpactor plugin
" Include use statement
nmap <Leader>u <cmd>call phpactor#UseAdd()<cr>
" Invoke the context menu
nmap <Leader>mm <cmd>call phpactor#ContextMenu()<cr>
" Invoke the navigation menu
nmap <Leader>nn <cmd>call phpactor#Navigate()<cr>
" Goto definition of class or class member under the cursor
nmap <Leader>oo <cmd>call phpactor#GotoDefinition()<cr>
nmap <Leader>oh <cmd>call phpactor#GotoDefinition('hsplit')<cr>
nmap <Leader>ov <cmd>call phpactor#GotoDefinition('vsplit')<cr>
nmap <Leader>ot <cmd>call phpactor#GotoDefinition('tabnew')<cr>
" Show brief information about the symbol under the cursor
nmap <Leader>K <cmd>call phpactor#Hover()<cr>
" Transform the classes in the current file
nmap <Leader>tt <cmd>call phpactor#Transform()<cr>
" Generate a new class (replacing the current file)
nmap <Leader>cc <cmd>call phpactor#ClassNew()<cr>
" Extract expression (normal mode)
nmap <silent><Leader>ee <cmd>call phpactor#ExtractExpression(v:false)<cr>
" Extract expression from selection
vmap <silent><Leader>ee <cmd><C-U>call phpactor#ExtractExpression(v:true)<cr>
" Extract method from selection
vmap <silent><Leader>em <cmd><C-U>call phpactor#ExtractMethod()<cr>

" vuejs
" vim vue
let g:vue_disable_pre_processors=1
" vim vue plugin
let g:vim_vue_plugin_load_full_syntax = 1
