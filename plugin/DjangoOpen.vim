" author: Espen Angell Kristiansen <post@espenak.net>

python << EOF
import vim
import os.path
import sys

class DjangoOpen(object):
    def __init__(self):
        self.filepath = os.path.abspath(os.path.normpath(vim.current.buffer.name))
        self.root = self._find_root()
        self.modelspath = os.path.join(self.root, 'models.py')
        self.viewspath = os.path.join(self.root, 'views.py')
        self.urlspath = os.path.join(self.root, 'urls.py')
        self.testsdir = os.path.join(self.root, 'tests')
        self.appname = os.path.basename(self.root)
        self.templatesdir = os.path.join(self.root, 'templates', self.appname)
        self.staticdir = os.path.join(self.root, 'static', self.appname)

    def _find_root(self):
        root = self.filepath
        while True:
            root = os.path.dirname(os.path.abspath(root))
            if not os.path.exists(os.path.join(root, '__init__.py')):
                break
            modelsfile = os.path.join(root, 'models.py')
            if os.path.exists(modelsfile):
                return root
        raise ValueError('Could not find the Django app root (the directory with models.py)')
        return False

    def _find_testfile(self, create_dir=False):
        root_relfilepath = os.path.relpath(self.filepath, self.root)
        testsdirpath = os.path.split(os.path.dirname(root_relfilepath))
        testsdir = os.path.join(self.root, 'tests', *testsdirpath)
        if create_dir and not os.path.exists(testsdir):
            os.makedirs(testsdir)
        filename = os.path.basename(self.filepath)
        preferred_testfilename = 'test_{}'.format(filename)
        for testfilename in (preferred_testfilename, filename):
            testfilename = os.path.join(testsdir, filename)
            if os.path.exists(testfilename):
                return testfilename
        return os.path.join(testsdir, preferred_testfilename)

    def vsplitopen_test(self, create_dir=False):
        vim.command('rightbelow vsplit {}'.format(self._find_testfile(create_dir)))
    def tabopen_test(self, create_dir=False):
        vim.command('tabedit {}'.format(self._find_testfile(create_dir)))

    def tabopen_static(self, create_dir=False):
        if create_dir:
            os.path.makedirs(self.staticdir)
        vim.command('tabedit {}'.format(self.staticdir))

    def tabopen_templates(self):
        if create_dir:
            os.path.makedirs(self.templatesdir)
        vim.command('tabedit {}'.format(self.templatesdir))

    def tabopen_models(self):
        vim.command('tabedit {}'.format(self.modelspath))
    def vsplitopen_models(self):
        vim.command('rightbelow vsplit {}'.format(self.modelspath))

    def tabopen_urls(self):
        vim.command('tabedit {}'.format(self.urlspath))
    def vsplitopen_urls(self):
        vim.command('rightbelow vsplit {}'.format(self.urlspath))

    def tabopen_views(self):
        vim.command('tabedit {}'.format(self.viewspath))
    def vsplitopen_views(self):
        vim.command('rightbelow vsplit {}'.format(self.viewspath))

    def vsplitopen_root(self):
        vim.command('rightbelow vsplit {}'.format(self.root))
    def tabopen_root(self):
        vim.command('tabedit {}'.format(self.root))

    def vsplitopen_testsdir(self):
        vim.command('rightbelow vsplit {}'.format(self.testsdir))
    def tabopen_testsdir(self):
        vim.command('tabedit {}'.format(self.testsdir))


    def _find_staticsubdir(self, name):
        for root, dirs, files in os.walk(self.staticdir):
            if os.path.basename(root) == name:
                return os.path.abspath(root)
        raise ValueError('No directory named: {} in {}'.format(name, self.staticdir))

    def _find_app_coffee(self):
        return self._find_staticsubdir('app_coffee')

    def vsplitopen_appcoffee(self):
        vim.command('rightbelow vsplit {}'.format(self._find_app_coffee()))
    def tabopen_appcoffee(self):
        vim.command('tabedit {}'.format(self._find_app_coffee()))


#altfiles = AlternateFiles()
#altfilesWin = AlternateFiles(openInWin=True)

EOF

fun! DjangoOpenSetup()
    " NOTE: The first letters are ``Dj`` for Django, and the third letter is one
    " of:
    " - V: vsplit
    " - T: tabedit
    command! -nargs=0 DjVroot :python DjangoOpen().vsplitopen_root()
    command! -nargs=0 DjTroot :python DjangoOpen().tabopen_root()
    command! -nargs=0 DjVtestsdir :python DjangoOpen().vsplitopen_testsdir()
    command! -nargs=0 DjTtestsdir :python DjangoOpen().tabopen_testsdir()
    command! -nargs=0 DjVmodels :python DjangoOpen().vsplitopen_models()
    command! -nargs=0 DjTmodels :python DjangoOpen().tabopen_models()
    command! -nargs=0 DjVurls :python DjangoOpen().vsplitopen_urls()
    command! -nargs=0 DjTurls :python DjangoOpen().tabopen_urls()
    command! -nargs=0 DjVviews :python DjangoOpen().vsplitopen_views()
    command! -nargs=0 DjTviews :python DjangoOpen().tabopen_views()
    command! -nargs=0 DjVtest :python DjangoOpen().vsplitopen_test()
    command! -nargs=0 DjVtestCreate :python DjangoOpen().vsplitopen_test(create_dir=True)
    command! -nargs=0 DjTtest :python DjangoOpen().tabopen_test()
    command! -nargs=0 DjTtestCreate :python DjangoOpen().tabopen_test(create_dir=True)
    command! -nargs=0 DjTtplDir :python DjangoOpen().tabopen_templates()
    command! -nargs=0 DjTtplDirCreate :python DjangoOpen().tabopen_templates(create_dir=True)
    command! -nargs=0 DjTstaticDir :python DjangoOpen().tabopen_static()
    command! -nargs=0 DjTstaticDirCreate :python DjangoOpen().tabopen_static(create_dir=True)
    command! -nargs=0 DjVappcoffee :python DjangoOpen().vsplitopen_appcoffee()
    command! -nargs=0 DjTappcoffee :python DjangoOpen().tabopen_appcoffee()
endfun

"au BufNewFile,BufRead *.h call SetupAltFile()

au BufNewFile,BufRead *.py call DjangoOpenSetup()
