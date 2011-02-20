python << EOF
import vim
from os.path import join, dirname


def current_cmake_path():
	return join(dirname(vim.current.buffer.name), "CMakeLists.txt")

def open_cmakelists(editcmd):
    vim.command("%s %s" % (editcmd, current_cmake_path()))

EOF

fun! g:SetupCmakehelpers()
	nnoremap <Leader>cm :py open_cmakelists("tabedit")<CR>
endfun
