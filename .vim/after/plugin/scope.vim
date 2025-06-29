vim9script

import autoload 'scope/fuzzy.vim'

def FindFromGitRoot()
  var gitdir = system('git rev-parse --show-toplevel 2>/dev/null')->trim()
  if v:shell_error != 0 || gitdir == getcwd()
    gitdir = '.'
  endif
  fuzzy.File(fuzzy.FindCmd(gitdir))
enddef

nnoremap <Leader>ff <scriptcmd>FindFromGitRoot()<CR>
nnoremap <Leader>fb <scriptcmd>fuzzy.Buffer()<CR>
nnoremap <Leader>s  <scriptcmd>fuzzy.LspDocumentSymbol()<CR>

