let g:netrw_liststyle    = 3
let g:netrw_banner       = 0
let g:netrw_winsize      = 15
let g:netrw_alto         = 1
let g:netrw_altv         = 1
augroup NetrwOpend
  autocmd!
  autocmd filetype netrw nnoremap <buffer> <C-l>   <C-W>w
  autocmd filetype netrw nmap     <buffer> h       -
  autocmd filetype netrw nmap     <buffer> l       <CR>
  autocmd filetype netrw nmap     <buffer> <Space> gn
  autocmd filetype netrw setlocal cursorlineopt=line
augroup end
