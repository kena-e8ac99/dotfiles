" Options {{{1
  " Behaviour {{{2
    filetype plugin indent on
    set hidden
    set autoread
    set autochdir
    set wildmenu
    set wildmode=longest:full,full
    set completeopt=menuone,noinsert
  " Encoding {{{2
    set fileencodings=utf-8,sjis
    set ambiwidth=double
  " Selection {{{2
    set backspace=indent,eol,start
    set virtualedit=block
  " Fold {{{2
    set foldmethod=marker
    set foldlevel=99
  " Indentation {{{2
    set formatoptions-=ro
    set autoindent
    set smartindent
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set expandtab
  " Search {{{2
    set ignorecase
    set smartcase
    set wrapscan
    set incsearch
    set hlsearch
  " Spliting {{{2
    set splitbelow
    set splitright
  " Bracket {{{2
    set matchpairs+=<:>
    set showmatch
  " Appearance {{{2
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
    set listchars=tab:>-,trail:▮
  " Colorscheme {{{2
    set background=dark
    colorscheme nord
  " StatusLine {{{2
    set cmdheight=2
    set laststatus=2
    set noshowmode
    set showcmd
" Mapping {{{1
  " NormalMode {{{2
    nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
    nnoremap          +          <C-a>
    nnoremap          -          <C-x>
    nnoremap          j          gj
    nnoremap          k          gk
    nnoremap <silent> <Up>       :m .-2<CR>
    nnoremap <silent> <Down>     :m .+1<CR>
    nnoremap          <Left>     <<
    nnoremap          <Right>    >>
    nnoremap          <CR>       i<CR><ESC>
    nnoremap <silent> <C-p>      :bp<CR>
    nnoremap <silent> <C-n>      :bn<CR>
    nnoremap          <C-h>      <C-w><C-h>
    nnoremap          <C-j>      <C-w><C-j>
    nnoremap          <C-k>      <C-w><C-k>
    nnoremap          <C-l>      <C-w><C-l>
  " InsertMode {{{2
    inoremap          <Nul>      <Nop>
    inoremap <expr>   <CR>       pumvisible() ? "<C-y>"  : "<CR>"
    inoremap <expr>   <Tab>      pumvisible() ? "<Down>" : "<Tab>"
    inoremap <expr>   <S-Tab>    pumvisible() ? "<Up>"   : "<S-Tab>"
  " VisualMode {{{2
    xnoremap <silent> <Up>       :m '<-2<CR>gv=gv
    xnoremap <silent> <Down>     :m '>+1<CR>gv=gv
    xnoremap          <Left>     <gv
    xnoremap          <Right>    >gv
" Auto Command {{{1
  " Disable automatic comment insertion entering new line. {{{2
    augroup disable_automatic_comment_insertion
      autocmd!
      autocmd FileType * setlocal formatoptions-=ro
    augroup end
  " Disable Fcitx when starting vim and leaving from insert mode {{{2
  "  augroup disable_fcitx
  "    autocmd!
  "    autocmd VimEnter    * call system("fcitx-remote -c")
  "    autocmd InsertLeave * call system("fcitx-remote -c")
  "  augroup end
  "Trim trailing white spaces before writing. {{{2
    function s:TrimTrailingWhiteSpaces() abort
      const l:pos = getpos(".")
      %s/\s\+$//e
      call setpos(".", l:pos)
    endfunction

    augroup trim_trailing_whitespaces_before_writing
      autocmd!
      autocmd BufWritePre * :call s:TrimTrailingWhiteSpaces()
    augroup end
" Generate help {{{1
  packloadall
  silent! helptags ALL
" }}}1
