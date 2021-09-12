let g:lightline             = {}
let g:lightline.colorscheme = 'nord'

let g:lightline.active      = {}
let g:lightline.active.left =
\ [
  \ ['show_mode', 'paste'],
  \ ['show_git_branch', 'show_path', 'show_modified']
\ ]
let g:lightline.active.right =
\ [
  \ ['lsp_error', 'lsp_warning', 'lsp_ok'],
  \ ['show_line', 'show_column'],
  \ ['show_format', 'show_encoding', 'show_file_type']
\ ]

let g:lightline.inactive       = {}
let g:lightline.inactive.left  =
\ [['show_git_branch', 'show_full_path', 'show_modified']]
let g:lightline.inactive.right = []

let g:lightline.component_function                 = {}
let g:lightline.component_function.show_mode       = 'ShowMode'
let g:lightline.component_function.show_format     = 'ShowFileFormat'
let g:lightline.component_function.show_encoding   = 'ShowFileEncoding'
let g:lightline.component_function.show_file_type  = 'ShowFileType'
let g:lightline.component_function.show_line       = 'ShowLine'
let g:lightline.component_function.show_column     = 'ShowColumn'
let g:lightline.component_function.show_full_path  = 'ShowFullPath'
let g:lightline.component_function.show_path       = 'ShowRelativePath'
let g:lightline.component_function.show_modified   = 'ShowModified'
let g:lightline.component_function.show_git_branch = 'ShowGitBranch'
let g:lightline.component_function.lsp_diagnostic  = 'ShowLspDiagnostic'

let g:lightline.component_expand                   = {}
let g:lightline.component_expand.lsp_error         = 'ShowLspError'
let g:lightline.component_expand.lsp_warning       = 'ShowLspWarning'
let g:lightline.component_expand.lsp_ok            = 'ShowLspOK'

let g:lightline.component_type                     = {}
let g:lightline.component_type.lsp_error           = 'error'
let g:lightline.component_type.lsp_warning         = 'warning'
let g:lightline.component_type.lsp_ok              = 'right'

function! ShowMode() abort
  return &filetype =~# '^\%(help\|netrw\|fern\|vista\)' ? '' : lightline#mode()
endfunction

function! ShowFileFormat() abort
  if &filetype =~# '^\%(netrw\|fern\|vista\)'
    return ''
  endif
  if exists('*nerdfont#find')
    return &fileformat . ' ' . nerdfont#fileformat#find()
  else
    return &fileformat
  endif
endfunction

function! ShowFileEncoding() abort
  return &filetype =~# '^\%(netrw\|fern\|vista\)' ? '' : &fileencoding
endfunction

function! ShowFileType() abort
  if &filetype =~# '^\%(netrw\|fern\|vista\)'
    return ''
  endif
  if exists('*nerdfont#find')
    return &filetype . ' ' . nerdfont#find()
  else
    return &filetype
  endif
endfunction

function! ShowModified() abort
  if &filetype =~# '^\%(netrw\|fern\|vista\)'
    return ''
  endif
  if &modified
    return '+'
  endif
  if !&modifiable
    return '-'
  endif
  return ''
endfunction

function! ShowLine() abort
  return &filetype =~# '^\%(netrw\|fern\|vista\)'
                     \ ? '' : 'ﴵ ' . line('.') . '/' . line('$')
endfunction

function! ShowColumn() abort
  return &filetype =~# '^\%(netrw\|fern\|vista\)'
                     \ ? '' : 'ﴳ ' . col('.') . '/' . col('$')
endfunction

function! s:SubstitutePath(path) abort
  let l:result = a:path
  if &filetype ==# 'fern'
    let l:result = substitute(l:result, '^fern://\w*:\d*/file://\(.*\);\$',
                            \ '\1', '')
  endif
  return substitute(l:result, '^/home/\w*', '~', '')
endfunction

function! ShowFullPath() abort
  return &filetype =~# '^\%(netrw\|vista\)' ? ''
                                          \ : s:SubstitutePath(expand('%:p'))
endfunction

function! ShowRelativePath() abort
  return &filetype =~# '^\%(netrw\|vista\)' ? '' : s:SubstitutePath(expand('%'))
endfunction

function! ShowGitBranch() abort
  if &filetype =~# '^\%(help\|netrw\|fern\|vista\)' || !exists("*FugitiveHead")
    return ''
  endif
  const l:branch = FugitiveHead()
  if empty(l:branch)
    return ''
  endif
  return '' . l:branch
endfunction

function! ShowLspError() abort
  const l:error = lsp#get_buffer_diagnostics_counts().error
  return l:error == 0 ? '' : g:lsp_diagnostics_signs_error.text . l:error
endfunction

function! ShowLspWarning() abort
  const l:warning = lsp#get_buffer_diagnostics_counts().warning
  return l:warning == 0 ? '' : g:lsp_diagnostics_signs_warning.text . l:warning
endfunction

function! ShowLspOK() abort
  if &filetype !=# 'cpp'
    return ''
  endif
  const l:diag = lsp#get_buffer_diagnostics_counts()
  const l:count = l:diag.error + l:diag.warning
  return l:count == 0 ? '' : ''
endfunction
