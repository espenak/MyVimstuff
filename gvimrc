if has("gui_macvim")
	set guifont=Monaco:h12
	set antialias
	command BigFont set guifont=Monaco:h18<CR>
	command NormalFont set guifont=Monaco:h12<CR>
else
set guifont=Andale\ Mono\ 11
endif


" Remove menubar
set guioptions-=T

" Remove toolbar
"set guioptions-=m

set numberwidth=5
set columns=87
set lines=57

if exists('&macatsui')
	set nomacatsui
endif


"colorscheme molokai
"set background=light
"colorscheme default

set background=light
colorscheme osx_like

if filereadable(expand("~/.vim/gvimrc.local"))
	source ~/.vim/gvimrc.local
endif
