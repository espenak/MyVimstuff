" author: Espen Angell Kristiansen <post@espenak.net>

python << EOF
import vim
from os.path import join, dirname


def current_cmake_path():
	return join(dirname(vim.current.buffer.name), "CMakeLists.txt")

def open_cmakelists():
    cmakepath = current_cmake_path()
    try:
        vim.command("sbuffer %s" % (cmakepath))
    except vim.error, e:
        vim.command("new")
        vim.command("edit %s" % (cmakepath))

EOF

fun! g:SetupCmakehelpers()
	nnoremap <Leader>cm :py open_cmakelists()<CR>
	"nnoremap <Leader>cmt :py open_cmakelists("tabedit")<CR>
endfun
