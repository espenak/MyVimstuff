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


" Tell vim to remember certain things when we exit
"  '50  :	marks will be remembered for up to 10 previously edited files
"  "100 :	will save up to 100 lines for each register
"  :20  :	up to 20 lines of command-line history will be remembered
"  %    : 	saves and restores the buffer list
"  n... : 	where to save the viminfo files
set viminfo='50,\"100,:20,%,n~/.viminfo


" Filetypes
au BufRead,BufNewFile *.rst setlocal filetype=txt
au BufRead,BufNewFile *.apt setlocal filetype=txt
au BufRead,BufNewFile README setlocal filetype=txt
au BufRead,BufNewFile INSTALL setlocal filetype=txt
au BufRead,BufNewFile TODO setlocal filetype=txt
au BufRead,BufNewFile BUGS setlocal filetype=txt
au BufRead,BufNewFile *.h setlocal filetype=cpp.doxygen
au BufRead,BufNewFile *.mkd setlocal filetype=mkd
au BufRead,BufNewFile *.md setlocal filetype=mkd
au BufRead,BufNewFile *.zcml setlocal filetype=xml
au BufRead,BufNewFile *.pt setlocal filetype=xml
au BufRead,BufNewFile *.doctest setlocal filetype=doctest
au BufRead,BufNewFile *.django.html setlocal filetype=htmldjango
au BufRead,BufNewFile SConscript setlocal filetype=python
au BufNewFile,BufRead *.cu setlocal filetype=cpp.doxygen
au BufNewFile,BufRead *.cl setlocal filetype=opencl
au BufRead,BufNewFile *.json setlocal filetype=json
au BufRead,BufNewFile *.h setlocal filetype=cpp


" taglist
inoremap <F11> <ESC>:TlistToggle<CR>
noremap <F11> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth=70
let Tlist_Show_One_File = 0
let Tlist_Inc_Winwidth = 0
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Compact_Format = 1
let Tlist_Sort_Type = "name"
"let Tlist_Display_Prototype = 1


" General global shortcuts
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
noremap <Leader>tt <ESC>:tabnew<CR>


" Plugin settings
let g:proj_flags="cgLsStmv"    " Project.vim settings
let g:vimwiki_list = [{'path': '~/Dropbox/masterwiki/', 'path_html': '~/Dropbox/html_masterwiki/', 'auto_export': 1}, {'path': '~/Dropbox/personalwiki/', 'path_html': '~/Dropbox/html_personalwiki/', 'auto_export': 1}]

map <Leader>dec<CR> <C-x>
map <Leader>inc<CR> <C-a>


" FuzzyFinder
map <Leader>ff :FufFile<CR>
map <Leader>fg :FufFile **/<CR>
map <Leader>fdg :FufDir **/<CR>
let g:fuf_dir_exclude='\v(^|[/\\])(\.hg|\.git|\.bzr|build)($|[/\\])'
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|DS_Store)$|(^|[/\\])(\.hg|\.git|\.bzr|build)($|[/\\])'


" Easygrep
let EasyGrepMode=2
let EasyGrepFileAssociations=expand("~/.vim/easygrep.txt")
let EasyGrepRecursive=1
