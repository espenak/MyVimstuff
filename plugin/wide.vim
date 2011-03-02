function! g:WideWidow()
    set columns=172
    exe "normal \<c-w>\="
endfunction

function! g:NoWideWindow()
    set columns=92
    exe "normal \<c-w>\="
endfunction

command Wide call g:WideWidow()
command NoWide call g:NoWideWindow()
