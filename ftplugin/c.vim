let g:load_doxygen_syntax=1
"highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
"setlocal colorcolumn=66
setlocal textwidth=79
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://
setlocal complete-=i  " This seems to speed completion up a lot!
setlocal nowrap
setlocal makeprg=make\ -C\ build\ -j10

" ctags
let g:CtagsHelperCtagsOpts = "--c++-kinds=+p --fields=+iaS --extra=+q"

setlocal shiftwidth=4
setlocal tabstop=4
setlocal cindent
setlocal expandtab
setlocal cinoptions+=(0
call g:BracketMap()

let b:AstyleOptions = "--style=allman --indent-namespaces --indent-classes --indent-cases"
let b:AstyleFilePatt = '"*.cc" "*.h"'
map <Leader>in :call g:AstyleIndentCurrentBuffer(b:AstyleOptions)<CR>
map <Leader>rin :call g:AstyleIndentDirRecursive(b:AstyleOptions, b:AstyleFilePatt)<CR>

call g:SetupCmakehelpers()

" Calculate foldlevel by counting namespaces
python << EOF
import vim

def countNamespaces():
    namespaces = 0
    for line in vim.current.buffer:
        if "namespace" in line and not "}" in line and not "using" in line:
            namespaces += 1
    return namespaces

def foldlevelExceptNamespaces():
    foldlevel = countNamespaces()
    name = vim.current.buffer.name
    ext = name.rsplit(".", 1)[1]
    if ext in ('h', 'hpp', 'hh', 'H'):
        foldlevel += 1
    vim.command("set foldlevel=%d" % foldlevel)
    vim.command("set foldnestmax=%d" % (foldlevel+1))
EOF
set foldmethod=syntax
py foldlevelExceptNamespaces()
call g:foldWithSpace()
