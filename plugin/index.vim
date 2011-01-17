function! CtagsHelperRecursive()
	exec("!ctags " . g:CtagsHelperCtagsOpts . " -R .")
endfunction

function! CtagsHelperCurrentFile()
	exec("!ctags " . g:CtagsHelperCtagsOpts . " %")
endfunction

function! CtagsHelperCurrentGitChanged()
	let l:files = substitute(system("git ls-files --other --exclude-standard --modified"), "\n", " ", "g")
	"echo(l:files)
	exec("!ctags " . g:CtagsHelperCtagsOpts . " " . l:files)
endfunction

map <Leader>inr :call CtagsHelperRecursive()<CR>
map <Leader>ing :call CtagsHelperCurrentGitChanged()<CR>
map <Leader>inc :call CtagsHelperCurrentFile()<CR>
map <Leader>jw :exec("tjump ".expand("<cword>"))<CR>
map <Leader>jt :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
