" author: Espen Angell Kristiansen <post@espenak.net>

python << EOF
import vim
import os.path
import sys

class DjangoOpen(object):
    def __init__(self):
        self.filepath = os.path.abspath(os.path.normpath(vim.current.buffer.name))
        self.approot = self._find_approot()
        self.modelspath = os.path.join(self.approot, 'models.py')
        self.testsdir = os.path.join(self.approot, 'tests')
        self.appname = os.path.basename(self.approot)
        self.templatesdir = os.path.join(self.approot, 'templates', self.appname)
        self.staticdir = os.path.join(self.approot, 'static', self.appname)

    def _find_approot(self):
        approot = self.filepath
        while True:
            approot = os.path.dirname(os.path.abspath(approot))
            if not os.path.exists(os.path.join(approot, '__init__.py')):
                break
            modelsfile = os.path.join(approot, 'models.py')
            if os.path.exists(modelsfile):
                return approot
        raise ValueError('Could not find the Django app root (the directory with models.py)')
        return False

    def _find_testfile(self, create_dir=False):
        approot_relfilepath = os.path.relpath(self.filepath, self.approot)
        testsdirpath = os.path.split(os.path.dirname(approot_relfilepath))
        testsdir = os.path.join(self.approot, 'tests', *testsdirpath)
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

    def vsplitopen_approot(self):
        vim.command('rightbelow vsplit {}'.format(self.approot))
    def tabopen_approot(self):
        vim.command('tabedit {}'.format(self.approot))

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
    command! -nargs=0 DjVapproot :python DjangoOpen().vsplitopen_approot()
    command! -nargs=0 DjTapproot :python DjangoOpen().tabopen_approot()
    command! -nargs=0 DjVtestsdir :python DjangoOpen().vsplitopen_testsdir()
    command! -nargs=0 DjTtestsdir :python DjangoOpen().tabopen_testsdir()
    command! -nargs=0 DjVmodels :python DjangoOpen().vsplitopen_models()
    command! -nargs=0 DjTmodels :python DjangoOpen().tabopen_models()
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
