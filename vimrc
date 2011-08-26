set nocompatible
syntax on
filetype plugin on
filetype plugin indent on  " enable loading the indent file for specific file types


" Common config for all filetypes
let mapleader = ","        " Redefine <Leader> from \ to ,
set ruler                  " show cursor line and column in the status line
set showmatch              " show matching brackets
set visualbell             " Stop beeping on error
set history=500            " Number of remembered commands
set backspace=2            " allow backspacing over everything in insert mode
set mouse=a                " Enable mouse in all editing modes (has no effect in gvim)
set linebreak              " Avoid breaking words when wrapping text (when using :set wrap)
set fileencoding=utf-8     " Use UTF-8
set encoding=utf-8         " Use UTF-8
set sidescroll=1           " How fast we should jump the screen when scrolling sideways
set switchbuf=usetab,split " Open file-links from the quickfix window in a existing or new tab
set tabstop=4
set shiftwidth=4           "number of spaces used by >> << and cindent
set smarttab
set expandtab
set laststatus=2           " Show filename and cursor position at the bottom of the screen
set wildmenu " turn on wild menu, try typing :h and press <Tab>
"set switchbuf=newtab,usetab " Things that switch buffers, like quickfix will open new tabs, but reuse already open tabs.
set switchbuf=useopen,split  " Things that switch buffers, like quickfix will open new windows, but reuse already open windows.
set nowrap                   " Don't wrap text
set hlsearch                 " Highlight search results

" Statusline is the line at the bottom of the screen, showing filename and
" other info.
set statusline=%#Identifier#%{winnr()}\             " window number
set statusline+=%*                                  " Switch back to normal statusline highlight
set statusline+=%f
set statusline+=%#Comment#\ %r%m                    " [RO][modified]
set statusline+=%#Comment#\ (\%L\ lines)[%l:%c]\    " Lines in file, lineno, colno
set statusline+=%*                                  " Switch back to normal statusline highlight


" Stuff that only works in 7.3 and greater
if v:version >= 703
    "set colorcolumn=80

    " Make vim keep undo history in ~/.vim/undodir
    set undofile
    set undodir=~/.vim/undodir
endif


" Tell vim to remember certain things when we exit
"  '50  :	marks will be remembered for up to 10 previously edited files
"  "100 :	will save up to 100 lines for each register
"  :20  :	up to 20 lines of command-line history will be remembered
"  %    : 	saves and restores the buffer list
"  n... : 	where to save the viminfo files
set viminfo='50,\"100,:20,%,n~/.viminfo

"set winminheight=0
"set winheight=10
"set winminheight=10

" Filetypes
au BufRead,BufNewFile *.rst setlocal filetype=rst
au BufRead,BufNewFile *.apt setlocal filetype=txt
au BufRead,BufNewFile README setlocal filetype=txt
au BufRead,BufNewFile INSTALL setlocal filetype=txt
au BufRead,BufNewFile TODO setlocal filetype=txt
au BufRead,BufNewFile BUGS setlocal filetype=txt
au BufRead,BufNewFile *.mkd setlocal filetype=markdown
au BufRead,BufNewFile *.md setlocal filetype=markdown
au BufRead,BufNewFile *.zcml setlocal filetype=xml
au BufRead,BufNewFile *.pt setlocal filetype=xml
au BufRead,BufNewFile *.doctest setlocal filetype=doctest
"au BufRead,BufNewFile *.django.html setlocal filetype=jsdjango
au BufRead,BufNewFile *.django.html setlocal filetype=javascript
au BufRead,BufNewFile SConscript setlocal filetype=python
au BufNewFile,BufRead *.cu setlocal filetype=cpp.doxygen
au BufNewFile,BufRead *.cl setlocal filetype=opencl
au BufRead,BufNewFile *.json setlocal filetype=json
au BufRead,BufNewFile *.h setlocal filetype=cpp
au BufRead,BufNewFile *.tex setlocal filetype=tex
au BufRead,BufNewFile *.kdl setlocal filetype=yaml
au BufRead,BufNewFile *.klg setlocal filetype=cpp



" Configure taglist plugin
inoremap <F11> <ESC>:TlistToggle<CR>
noremap <F11> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth=50
let Tlist_Show_One_File = 0
let Tlist_Inc_Winwidth = 1
let Tlist_Close_On_Select = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Compact_Format = 1
let Tlist_Sort_Type = "name"
"let Tlist_Display_Prototype = 1


" General global shortcuts
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>rs :%s/\<<C-r><C-w>\>/<C-r><C-w>
noremap <Leader>nt <ESC>:tabnew<CR>
noremap <Leader>pp <ESC>:YRShow<CR>
command! -complete=help -nargs=1 H tab help <args>
command! -nargs=0 ClearTrailingWhitespace %s/\s\+$//
command! -nargs=0 CodeBrowseRefresh !python ~/.vim/codeprojectbrowser.py

" Vimwiki
let g:vimwiki_list = [{'path': '~/Dropbox/masterwiki/', 'path_html': '~/Dropbox/html_masterwiki/', 'auto_export': 1}, {'path': '~/Dropbox/personalwiki/', 'path_html': '~/Dropbox/html_personalwiki/', 'auto_export': 1}]
let g:vimwiki_folding = 1
let g:vimwiki_fold_lists = 1
let g:vimwiki_fold_trailing_empty_lines = 1

function g:fuzzyFindFile()
    "exec("FufRenewCache")
    exec("FufFile **/")
endfunction
function g:fuzzyFindDir()
    exec("FufRenewCache")
    exec("FufDir **/")
endfunction

" FuzzyFinder
map <Leader>fg :call g:fuzzyFindFile()<CR>
map <Leader>fdg :call g:fuzzyFindDir()<CR>
let g:fuf_dir_exclude='\v(^|[/\\])(\.hg|\.git|\.bzr|build)($|[/\\])'
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|DS_Store|png|gif|pyc|pyo|class|jpg)$|(^|[/\\])(\.hg|\.git|\.bzr|build)($|[/\\])'

" Easygrep
let EasyGrepMode=2
let EasyGrepFileAssociations=expand("~/.vim/easygrep.txt")
let EasyGrepRecursive=1

" Toggle quickfix
let g:jah_Quickfix_Win_Height=20
map <Leader>qq :QFix<CR>


" Project.vim settings
let g:proj_flags="cgLsStmv"
au BufEnter *.vimprojects call g:foldWithSpace()

" Command-t settings
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowReverse=1


" Settings for the link plugin
python << EOF
import platform
os = platform.uname()[0]
if os == "Linux":
    linkOpeners = dict(
        http = "xdg-open %(url)s",
        v = "vim tabedit %(path)s",
        file = "xdg-open %(path)s"
    )
elif os == "Darwin": # Mac OSX
    linkOpeners = dict(
        http = "open %(url)s",
        v = "vim tabedit %(path)s",
        file = "open %(path)s"
    )
EOF


" Autoimport plugins in ~/.vim/bundle/
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


if executable('/usr/local/bin/ctags')
    let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif


let python_highlight_all = 1
runtime devilrysettings.vim


let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'open %URL%'

if filereadable(expand("~/.vim/vimrc.local"))
	source ~/.vim/vimrc.local
endif
