function! g:BracketMap()
	" Auto insert } after {
	inoremap {      {}<Left>
	inoremap {<CR>  {<CR>}<Esc>O
	inoremap {{     {
	inoremap {}     {}
endfunction
