
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


map <C-F12> :call CtagsHelperRecursive()<CR>
map <M-F12> :call CtagsHelperCurrentFile()<CR>
map <S-F12> :call CtagsHelperCurrentGitChanged()<CR>
