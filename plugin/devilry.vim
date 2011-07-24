function! s:setDevilrySettings()
    " Run tests using :make <args to test>
    compiler pyunit
    setlocal makeprg=python\ ~/code/devilry-django/devilry/projects/dev/manage.py\ test
endfunction

function! s:setDevilrySettingsIfInDevilry()
    let l:pathToCurrentFile = expand("%:p")
    " Check if path contains devilry
    if l:pathToCurrentFile =~ "devilry"
        call s:setDevilrySettings()
    endif
endfunction

au BufRead,BufNewFile *.py call s:setDevilrySettingsIfInDevilry()





python << EOF
import vim
from os.path import join, dirname, isdir, exists
from os import makedirs

def create_or_find_extjsclass(clspath):
    if not isdir('apps'):
        raise ValueError('No subdirectory named apps/')
    appname, subclspath = clspath.split('.', 1)
    subfilepath = join(*subclspath.split('.')) + '.js'
    realpath = join('apps', appname, 'static', 'extjs_classes', appname, subfilepath)
    if not exists(realpath):
        realdir = dirname(realpath)
        if not exists(realdir):
            makedirs(realdir)
        open(realpath, 'w').write("""Ext.define('devilry.{clspath}', {{
    
}});""".format(clspath=clspath))
    return realpath


def create_or_find_and_open_extjsclass(clspath):
    filepath = create_or_find_extjsclass(clspath)
    vim.command('edit {0}'.format(filepath))
EOF

command -nargs=1 ExtJsClass py create_or_find_and_open_extjsclass("<args>")
