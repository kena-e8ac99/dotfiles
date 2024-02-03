vim9script

if executable('clangd')
  var setting = {
    'func': lsp#register_server,
    'name': 'clangd',
    'cmd': (server_info) => ['/opt/clang/latest/bin/clangd', '-background-index'],
    'whitelist': ['c', 'cpp', 'cc']
  }
  setting.func(setting)
endif

def OnLspBufferEnabled()
  setlocal omnifunc=lsp#complete
  nmap     <buffer> gd   <plug>(lsp-definition)
  nmap     <buffer> gs   <plug>(lsp-document-symbol-search)
  nmap     <buffer> gS   <plug>(lsp-workspace-symbol-search)
  nmap     <buffer> gr   <plug>(lsp-references)
  nmap     <buffer> gi   <plug>(lsp-implementation)
  nmap     <buffer> gt   <plug>(lsp-type-definition)
  nmap     <buffer> <F2> <plug>(lsp-rename)
  nmap     <buffer> [g   <plug>(lsp-previous-diagnostic)
  nmap     <buffer> ]g   <plug>(lsp-next-diagnostic)
  nmap     <buffer> K    <plug>(lsp-hover)
  nnoremap <buffer> <expr><C-d> lsp#scroll(+4)
  nnoremap <buffer> <expr><C-u> lsp#scroll(-4)

  inoremap <expr>   <Tab>      pumvisible() ? '<C-n>' : vsnip#jumpable(1) ? '<plug>(vsnip-jump-next)' : exists('*copilot#Accept') ? copilot#Accept('<Tab>') : '<Tab>'
  inoremap <expr>   <S-Tab>    pumvisible() ? '<C-p>' : vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<S-Tab>'
  inoremap <expr>   <CR>       pumvisible() ? asyncomplete#close_popup() : '<CR>'

  setlocal foldmethod=expr
  setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
  setlocal foldtext=lsp#ui#vim#folding#foldtext()

  g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.hpp,*.h,*.cc,*.cpp execute('LspDocumentFormatSync')
enddef

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled OnLspBufferEnabled()
augroup END

g:lsp_diagnostics_enabled = 1
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_float_cursor = 1
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_diagnostics_signs_enabled = 1
g:lsp_diagnostics_signs_error = {'text': ''}
g:lsp_diagnostics_signs_warning = {'text': ''}
g:lsp_diagnostics_signs_information = {'text': ''}
g:lsp_diagnostics_signs_hint = {'text': ''}

