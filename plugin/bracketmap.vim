" author: Espen Angell Kristiansen <post@espenak.net>

function! g:BracketMap()
	inoremap {      }<ESC>i{<ESC>2la
    inoremap {<CR>  }<ESC>i{<ESC>a<CR><ESC>O
	inoremap {{     {
	inoremap }}     }<ESC>i{<ESC>2la

	inoremap (      ()<Left>
	inoremap (<CR>  (<CR>)<Esc>I
	inoremap ((     (
	inoremap ()     ()

	inoremap [      []<Left>
	inoremap [<CR>  [<CR>]<Esc>I
	inoremap [[     [
	inoremap []     []
endfunction
