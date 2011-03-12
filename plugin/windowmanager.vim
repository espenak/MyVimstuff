" author: Espen Angell Kristiansen <post@espenak.net>

function! b:WindowFocus()
    set winminheight=0
    set winheight=1
    exe "normal \<c-w>\="
    exe "normal \<c-w>\_"
endfunction

function! b:WindowOverview()
    set winminheight=0
    set winheight=10
    set winminheight=10
    exe "normal \<c-w>\="
    exe "normal \<c-w>\_"
endfunction

noremap <Leader>ff :call b:WindowFocus()<CR>
noremap <Leader>o :call b:WindowOverview()<CR>
