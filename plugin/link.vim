" Simple plugin to open a link on the current line. Made this because utl.vim
" seems to be unmaintained, and it had issues with some urls.
" 
" author: Espen Angell Kristiansen <post@espenak.net>
"
"
" Configuration
" --------------------------
" Add something like this to vimrc:
"    python << EOF
"    import platform
"    os = platform.uname()[0]
"    if os == "Linux":
"        linkOpeners = dict(
"            http = "xdg-open %(url)s",
"            v = "vim tabedit %(path)s",
"            file = "xdg-open %(path)s"
"        )
"    elif os == "Darwin": # Mac OSX
"        linkOpeners = dict(
"            http = "open %(url)s",
"            v = "vim tabedit %(path)s",
"            file = "open %(path)s"
"        )
"    EOF
" Available template vars:
"   - urlype (http, file, ...)
"   - path   (/this/is/my/file.txt, www.example.com/my/test, ...)
"   - url    (http://www.example.com/my/test, file:///this/is/my/file.txt, ...)


python << EOF
import re, vim, os

def getUrl():
    line = vim.current.line
    return re.match(r".*?(\w+://[^ ]*)", line).groups(1)[0]
def openUrl(url):
    urltype, path = url.split("://")
    opener = linkOpeners[urltype] % vars()
    if opener.startswith("vim"):
        vim.command(" ".join(opener.split(" ")[1:]))
    else:
        vim.command('call setreg("*", "%s")' % url) # add url to system clipboard
        os.system(opener)
EOF

command! -nargs=0 LinkOpen py openUrl(getUrl())
map <Leader>ll :LinkOpen<CR>
