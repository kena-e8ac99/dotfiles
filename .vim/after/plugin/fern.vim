let g:fern#default_hidden  = 1
let g:fern#default_exclude = '^\%(\.git\)$'
let g:fern#renderer        = "nerdfont"
let g:fern#drawer_width    = 24

augroup fern_setting
  autocmd!
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType fern nnoremap <buffer> <C-l>   <C-w><C-l>
  autocmd FileType fern nmap     <buffer> r       <plug>(fern-action-reload)
  autocmd FileType fern nmap     <buffer> <Space> <plug>(fern-action-cd)
  autocmd FileType fern nnoremap <buffer> <C-n>   <Nop>
  autocmd FileType fern nnoremap <buffer> <C-p>   <Nop>
  autocmd FileType fern setlocal nonumber
  autocmd FileType fern setlocal cursorlineopt=line
augroup end

augroup create_fern_sidebar
  autocmd!
  autocmd VimEnter * nested Fern . -drawer -reveal=% -stay
augroup end
