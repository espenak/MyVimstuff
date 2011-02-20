function! Uncrustify()
	let save_cursor = getpos(".")
	exec("write")
	exec("%d")
	exec("r! uncrustify -q -c ~/.vim/uncrustify/" . g:UncrustifyIndentFile . " -f %")
	exec("1d")
	call setpos('.', save_cursor)
endfunction

"map <Leader>in :call Uncrustify()<CR>
