function! g:BracketMap()
	" Auto insert } after {
	inoremap {      {}<Left>
	inoremap {<CR>  {<CR>}<Esc>O
	inoremap {{     {
	inoremap {}     {}

	inoremap (      ()<Left>
	inoremap (<CR>  (<CR>)<Esc>I
	inoremap ((     (
	inoremap ()     ()

	inoremap [      []<Left>
	inoremap [<CR>  [<CR>]<Esc>I
	inoremap [[     [
	inoremap []     []
endfunction
