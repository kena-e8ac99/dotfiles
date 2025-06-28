vim9script

# Behaviour
filetype plugin indent on
set hidden
set autoread
set autochdir
set clipboard=unnamedplus
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noinsert

# Encoding
set fileencodings=utf-8,sjis
set ambiwidth=double

# Selection
set backspace=indent,eol,start
set virtualedit=block

# Folding
set foldmethod=marker
set foldlevel=99

# Indent
set formatoptions-=ro
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

# Search
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

# Split
set splitbelow
set splitright

# Bracket
set matchpairs+=<:>
set showmatch

# Appearance
set lazyredraw
syntax enable
set signcolumn=yes
set title
set number
set cursorline
set cursorlineopt=number
set colorcolumn=81
set display=lastline
set list
set listchars=tab:>-,trail:-

# Colorscheme
set background=dark
colorscheme nord

# Statusline
set cmdheight=2
set laststatus=2
set showcmd
source ~/.vim/statusline.vim

# Key Mapping
g:mapleader = ","
## Normal Mode
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> +          <C-a>
nnoremap <silent> -          <C-x>
nnoremap <silent> j          gj
nnoremap <silent> k          gk
nnoremap <silent> <Up>       :m .-2<CR>
nnoremap <silent> <Down>     :m .+1<CR>
nnoremap <silent> <Left>     <<
nnoremap <silent> <Right>    >>
nnoremap <silent> <C-p>      :bp<CR>
nnoremap <silent> <C-n>      :bn<CR>
nnoremap <silent> <C-h>      <C-w><C-h>
nnoremap <silent> <C-j>      <C-w><C-j>
nnoremap <silent> <C-k>      <C-w><C-k>
nnoremap <silent> <C-l>      <C-w><C-l>

## Insert Mode
inoremap          <Null>     <Nop>

## Visual Mode
xnoremap <silent> <Up>       :m '<-2<CR>gv=gv
xnoremap <silent> <Down>     :m '>+1<CR>gv=gv
xnoremap <silent> <Left>     <gv
xnoremap <silent> <Right>    >gv

# Generate help
silent! helptags ALL

