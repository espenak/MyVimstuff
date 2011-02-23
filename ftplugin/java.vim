call g:BracketMap()
setlocal shiftwidth=4
setlocal tabstop=4
setlocal cindent
setlocal expandtab
setlocal nowrap
setlocal textwidth=79

setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%Csymbol\ \ :\ %m,%-C%.%#
setlocal makeprg=javac\ %

nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf
setlocal foldmethod=syntax
setlocal foldlevel=1
setlocal foldnestmax=2
