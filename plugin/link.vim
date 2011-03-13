" author: Espen Angell Kristiansen <post@espenak.net>

python << EOF
import re, vim, os

# Available vars:
#   - urlype (http, file, ...)
#   - path   (/this/is/my/file.txt, www.example.com/my/test, ...)
#   - url    (http://www.example.com/my/test, file:///this/is/my/file.txt, ...)
linkOpeners = dict(
    http = "open %(url)s",
    v = "vim tabedit %(path)s",
    file = "open %(path)s"
)


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
