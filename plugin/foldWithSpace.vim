" author: Espen Angell Kristiansen <post@espenak.net>

function! g:foldWithSpace()
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
    vnoremap <Space> zf
endf
