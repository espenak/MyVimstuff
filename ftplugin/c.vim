let g:load_doxygen_syntax=1
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
"setlocal colorcolumn=80
setlocal textwidth=79
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
setlocal complete-=i  " This seems to speed completion up a lot!
setlocal nowrap
set makeprg=make\ -C\ ../build

" ctags
let g:CtagsHelperCtagsOpts = "--c++-kinds=+p --fields=+iaS --extra=+q"

setlocal shiftwidth=4
setlocal tabstop=4
setlocal cindent
setlocal expandtab
setlocal cinoptions+=(0
let g:UncrustifyIndentFile= "allman.cfg"

call g:BracketMap()

let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1


let b:AstyleOptions = "--style=allman --indent-namespaces --indent-classes --indent-cases"
let b:AstyleFilePatt = '"*.cc" "*.h"'
map <Leader>in :call g:AstyleIndentCurrentBuffer(b:AstyleOptions)<CR>
map <Leader>rin :call g:AstyleIndentDirRecursive(b:AstyleOptions, b:AstyleFilePatt)<CR>

call g:SetupCmakehelpers()
