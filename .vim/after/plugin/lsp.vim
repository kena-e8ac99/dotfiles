vim9script

import autoload 'lsp/diag.vim' as lsp

# LSP Server setting
g:LspAddServer([
  {
    name: 'clangd',
    filetype: ['c', 'cpp'],
    path: '/usr/bin/clangd',
    args: ['--background-index']
  },
  {
    name: 'bash-language-server',
    filetype: ['sh', 'bash', 'zsh'],
    path: '/usr/bin/bash-language-server',
    args: ['start']
  }
])

# LSP options
g:LspOptionsSet({
  # Base
  echoSignature: true,
  ignoreMissingServer: false,
  keepFocusInDiags: true,
  keepFocusInReferences: true,
  showSignature: true,
  useQuickfixForLocations: false,
  # Completion
  autoComplete: true,
  completionMatcher: 'fuzzy',
  completionTextEdit: false,
  noNewlineInCompletion: false,
  omniComplete: false,
  useBufferCompletion: false,
  filterCompletionDuplicates: true,
  condensedCompletionMenu: true,
  # Diagnostics
  autoPopulateDiags: true,
  highlightDiagInline: true,
  showDiagInPopup: true,
  showDiagOnStatusLine: true,
  showDiagWithSign: true,
  showDiagWithVirtualText: false,
  diagVirtualTextAlign: 'above',
  diagVirtualTextWrap: 'wrap',
  # Highlight
  autoHighlight: true,
  autoHighlightDiags: true,
  semanticHightlight: false,
  # Hover
  hoverInPreview: false,
  # Inlay hints
  showInlayHints: false,
  # Popup
  popupBorder: true,
  # Outline
  outlineOnRight: true,
  outlineWinSize: 20,
  # Code actions
  hideDisabledCodeActions: true,
  usePopupInCodeAction: true,
  # Snippet
  snippetSupport: false,
  ultisnipsSupport: false,
  vsnipSupport: false,
  # Sign text
  diagSignErrorText: 'E',
  diagSignHintText: 'H',
  diagSignInfoText: 'I',
  diagSignWarningText: 'W',
})

def OnLspDiagsUpdated()
  final info = lsp.DiagsGetErrorCount(bufnr("%"))
  g:lspWarningCount = info->get("Warn", 0)
  g:lspErrorCount = info->get("Error", 0)
enddef

def OnLspAttached()
  nnoremap <buffer> gd        <Cmd>LspGotoDefinition<CR>
  nnoremap <buffer> gt        <Cmd>LspGotoTypeDef<CR>
  nnoremap <buffer> <Leader>h <Cmd>LspHover<CR>
  nnoremap <buffer> <Leader>q <Cmd>LspCodeAction<CR>
  nnoremap <buffer> <F2>      <Cmd>LspRename<CR>
  nnoremap <buffer> [d        <Cmd>LspDiag prevWrap<CR>
  nnoremap <buffer> ]d        <Cmd>LspDiag nextWrap<CR>

  inoremap <expr>   <Tab>     pumvisible() ? '<C-n>' : '<Tab>'
  inoremap <expr>   <S-Tab>   pumvisible() ? '<C-p>' : '<S-Tab>'

  autocmd! BufWritePre *.h,*.hpp,*.c,*.cc,*.cpp,*.sh,*.bashrc,*.zshrc execute('LspFormat')
  autocmd! User LspDiagsUpdated OnLspDiagsUpdated()
enddef

augroup lsp
  au!
  autocmd User LspAttached OnLspAttached()
augroup END

