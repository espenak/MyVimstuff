source ~/.vim/ftplugin/c.vim

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
    vim.command("setlocal foldlevel=%d" % foldlevel)
    vim.command("setlocal foldnestmax=%d" % (foldlevel+1))

EOF


setlocal foldmethod=syntax
py foldlevelExceptNamespaces()
