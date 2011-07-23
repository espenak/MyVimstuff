" author: Espen Angell Kristiansen <post@espenak.net>

function! g:WideWidow()
    set columns=200
    set lines=90
    exe "normal \<c-w>\="
endfunction

function! g:NoWideWindow()
    set columns=100
    set lines=90
    exe "normal \<c-w>\="
endfunction

command Wide call g:WideWidow()
command NoWide call g:NoWideWindow()
