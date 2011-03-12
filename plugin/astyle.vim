" author: Espen Angell Kristiansen <post@espenak.net>

function! g:AstyleIndentCurrentBuffer(astyleOpts)
	exec("%!astyle " . a:astyleOpts)
endfunction

function! g:AstyleIndentDirRecursive(astyleOpts, filePatt)
    exec("wall")
	exec("!astyle -n " . a:astyleOpts . "  --recursive " . a:filePatt)
endfunction
