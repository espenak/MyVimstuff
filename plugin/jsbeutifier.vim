" author: Espen Angell Kristiansen <post@espenak.net>

function! g:JsBeutifyCurrentBuffer()
	exec("%!python ~/.vim/jsbeautifier.py %")
endfunction
