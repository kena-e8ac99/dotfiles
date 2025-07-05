vim9script

set noshowmode

# Left
set statusline=
set statusline+=%0*\ %{ShowMode()}\ 
set statusline+=%1*\ %.20f\ 
set statusline+=%1*\ %m%r\ 
set statusline+=%2*\ %{ShowGitBranch()}

# Right
set statusline+=%=
set statusline+=%2*\ %{&filetype}\ 
set statusline+=%2*\ %{&fileencoding}\ 
set statusline+=%1*\ %-10(COL:%c/%{col('$')}%)\ 
set statusline+=%1*\ %-15(ROW:%l/%L%)\ 
set statusline+=%2*\ %{ShowLspError()}\ 
set statusline+=%2*\ %{ShowLspWarning()}

# Highlight
hi User1 ctermfg=007 ctermbg=240
hi User2 ctermfg=007 ctermbg=238

def g:ShowMode(): string
  const mode = mode()
  if mode ==# 'n'
    return "NORMAL"
  elseif mode ==? 'V'
    return "V-LINE"
  elseif mode ==? 'v'
    return "VISUAL"
  elseif mode ==# 'i'
    return "INSERT"
  elseif mode ==# 'R'
    return "REPLACE"
  elseif mode ==# 'c'
    return "COMMAND"
  else
    return ''
  endif
enddef

def g:ShowGitBranch(): string
  if !exists('b:git_branch')
    b:git_branch = ''
  endif
  return b:git_branch
enddef

def UpdateGitBranch()
  b:git_branch = ''
  if &filetype =~# '\%(netrw\|help\|vista\)'
    return
  endif
  if !executable('git')
    return
  endif

  const result = system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  b:git_branch = strlen(result) > 0 ? result->substitute('\n', '', 'g') : ''
enddef

augroup GitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * UpdateGitBranch()
augroup END

def g:ShowLspError(): string
  return exists('g:lspErrorCount') ? 'Error: ' .. g:lspErrorCount : ''
enddef

def g:ShowLspWarning(): string
  return exists('g:lspWarningCount') ? 'Warning: ' .. g:lspWarningCount : ''
enddef

