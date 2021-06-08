if executable('clangd')
  au User lsp_setup call lsp#register_server(
\ {
  \ 'name'     : 'clangd',
  \ 'cmd'      : {server_info->['clangd', '-background-index']},
  \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp']
\ })
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer>        [g    <plug>(lsp-previous-diagnostic)
  nmap <buffer>        ]g    <plug>(lsp-next-diagnostic)
  nmap <buffer>        <F2>  <plug>(lsp-rename)
  imap <buffer> <expr> <C-n> vsnip#jumpable(1)  ? "<plug>(vsnip-jump-next)"
                                              \ : "<C-n>"
  imap <buffer> <expr> <C-p> vsnip#jumpable(-1) ? "<plug>(vsnip-jump-prev)"
                                              \ : "<C-p>"
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup end

augroup lsp_diagnostic_updated
  autocmd!
  autocmd User lsp_diagnostics_updated call lightline#update()
augroup end

let g:lsp_diagnostics_enabled      = 1
let g:lsp_diagnostics_echo_cursor  = 1
let g:lsp_diagnostics_float_cursor = 1

let g:lsp_diagnostics_signs_enabled     = 1
let g:lsp_diagnostics_signs_error       = {'text': ''}
let g:lsp_diagnostics_signs_warning     = {'text': ''}
let g:lsp_diagnostics_signs_information = {'text': ''}
let g:lsp_diagnostics_signs_hint        = {'text': ''}
