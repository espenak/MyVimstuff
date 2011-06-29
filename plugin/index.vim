function! CtagsHelperRecursive()
    if executable('exuberant-ctags')
        " On Debian Linux, exuberant ctags is installed
        " as exuberant-ctags
        let b:ctags = 'exuberant-ctags'
    elseif executable('exctags')
        " On Free-BSD, exuberant ctags is installed as exctags
        let b:ctags = 'exctags'
    elseif executable('/usr/local/bin/ctags')
        let b:ctags = '/usr/local/bin/ctags'
    elseif executable('ctags')
        let b:ctags = 'ctags'
    else
        echomsg 'Taglist: Exuberant ctags (http://ctags.sf.net) ' .
                    \ 'not found in PATH. Plugin is not loaded.'
    endif
	exec("!" . b:ctags . " " . g:CtagsHelperCtagsOpts . " -R .")
endfunction

map <Leader>ix :call CtagsHelperRecursive()<CR>
map <Leader>jw :exec("tjump ".expand("<cword>"))<CR>
map <Leader>jt :tab split<CR>:exec("tjump ".expand("<cword>"))<CR>
