let g:load_doxygen_syntax=1
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
"setlocal colorcolumn=80
setlocal textwidth=79
setlocal cindent
setlocal expandtab
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
setlocal complete-=i  " This seems to speed completion up a lot!
setlocal nowrap
set makeprg=make\ -C\ build

" ctags
let g:CtagsHelperCtagsOpts = "--c++-kinds=+p --fields=+iaS --extra=+q"
