function! g:BracketMap()
	" Auto insert }]) after {[(

	"inoremap {      {}<Left>
	"inoremap {<CR>  {<CR>}<Esc>O
	"inoremap {{     {
	"inoremap {}     {}

    " This version does not break folding!
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
