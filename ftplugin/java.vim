call g:BracketMap()
setlocal shiftwidth=4
setlocal tabstop=4
setlocal cindent
setlocal expandtab
setlocal nowrap
setlocal textwidth=79

setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%Csymbol\ \ :\ %m,%-C%.%#
setlocal makeprg=javac\ %
