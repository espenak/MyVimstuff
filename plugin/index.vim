function! CtagsHelperRecursive()
	exec("!ctags " . g:CtagsHelperCtagsOpts . " -R .")
endfunction

map <Leader>ix :call CtagsHelperRecursive()<CR>
map <Leader>jw :exec("tjump ".expand("<cword>"))<CR>
map <Leader>jt :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
