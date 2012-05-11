setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
setlocal smartindent
setlocal textwidth=0
setlocal nosmartindent
"let g:python_highlight_all=1
let python_highlight_all=1


" Add all python files on path to the 'gf' path
"     CTRL-W gf : file under cursor in new tab
"python << EOF
"import os
"import sys
"import vim
"for p in sys.path:
	"if os.path.isdir(p):
		"vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF
setlocal path +=~/src/django-trunk


setlocal iskeyword+=-

"highlight OverCommentLength guibg=#dddddd
"let w:m1=matchadd('OverCommentLength', '\%<80v.\%>77v', -1)
"let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)



" OMNI complete (ctags) and cross referencing ctags+cscope
"map <C-F12> :!ctags --python-kinds=-i -R .<CR>:!~/.vim/bin/pycscope.py -R .<CR>
if(filereadable("cscope.out"))
	cscope add cscope.out
endif

map <S-f> :exec("cscope find c ".expand("<cword>"))<CR>
map <S-g> :tab split<CR>:exec("cscope find c ".expand("<cword>"))<CR>

let g:CtagsHelperCtagsOpts = "--python-kinds=-i"
let Tlist_Show_One_File = 1



set statusline=%#Identifier#%{winnr()}\             " window number
set statusline+=%*                                  " Switch back to normal statusline highlight
set statusline+=%f
set statusline+=%#Comment#\ %r%m                    " [RO][modified]
set statusline+=%#Comment#\ (\%L\ lines)[%l:%c]\    " Lines in file, lineno, colno
set statusline+=%*                                  " Switch back to normal statusline highlight
set statusline+=\ %{TagInStatusLine()}
