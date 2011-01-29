let g:load_doxygen_syntax=1
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
"setlocal colorcolumn=80
setlocal textwidth=79
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
setlocal complete-=i  " This seems to speed completion up a lot!
setlocal nowrap
set makeprg=make\ -C\ build

" ctags
let g:CtagsHelperCtagsOpts = "--c++-kinds=+p --fields=+iaS --extra=+q"

setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1 
setlocal shiftwidth=2 
setlocal tabstop=8 
setlocal cindent
setlocal expandtab
let g:UncrustifyIndentFile= "gnu-indent.cfg"

call g:BracketMap()

let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1
let g:clang_snippets=1
