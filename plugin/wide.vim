" author: Espen Angell Kristiansen <post@espenak.net>

function! g:WideWidow()
    set columns=220
    set lines=78
    exe "normal \<c-w>\="
endfunction

function! g:NoWideWindow()
    set columns=100
    set lines=78
    exe "normal \<c-w>\="
endfunction

command Wide call g:WideWidow()
command NoWide call g:NoWideWindow()
