from os.path import expanduser, join, basename, abspath
import json
import os
from fnmatch import fnmatchcase


class Project(object):
    def __init__(self, dirpath):
        self.dirpath = dirpath
        self.subdirs = []

    def getbasename(self):
        return basename(self.dirpath)


class BaseDirectory(object):
    def __init__(self, dirpath):
        self.dirpath = expanduser(dirpath)

    def getbasename(self):
        return basename(self.dirpath)

    def ignoredir(self, dirpath, subdirs, files):
        return False

    def formatdirpath(self, dirpath, subdirs, files):
        return dirpath

    def relpath(self, path):
        path = path.replace(abspath(self.dirpath), '')
        path = path[1:]
        if path == '':
            return '.'
        else:
            return path

    def filterfiles(self, dirpath, files):
        return files

class PythonDirectory(BaseDirectory):
    def format_file(self, filename):
        return filename.replace('.py', '')

    def filterfiles(self, dirpath, files):
        return [f for f in files if f.endswith('.py')]

    def ignoredir(self, dirpath, subdirs, files):
        return files == ['__init__.py'] or len(files) == 0

    def formatdirpath(self, dirpath, subdirs, files):
        pypath = self.relpath(dirpath).replace(os.sep, '.')
        return pypath

class Directory(BaseDirectory):
    def __init__(self, dirpath, ignore):
        super(Directory, self).__init__(dirpath)
        self.ignore = ignore

    def filterfiles(self, dirpath, files):
        filepaths = [(self.relpath(join(dirpath, f)), f) for f in files]
        filteredfiles = []
        for filepath, filename in filepaths:
            matched = False
            for pattern in self.ignore:
                if fnmatchcase(filepath, pattern):
                    matched = True
            if not matched:
                filteredfiles.append(filename)
        return filteredfiles

    def ignoredir(self, dirpath, subdirs, files):
        #return True
        return len(files) == 0

    def formatdirpath(self, dirpath, subdirs, files):
        return self.relpath(dirpath)



class Parser(object):
    def __init__(self, index):
        self.projects = self.parse(index)

    def _handle(self, dirname, value):
        handler = getattr(self, 'handle_' + value['handler'])
        del value['handler']
        return handler(dirname, **value)

    def parse(self, dct, indentlevel=0):
        projorhiddendirs = []
        for dirname, value in dct.iteritems():
            projorhiddendirs += self._handle(dirname, value)
        return projorhiddendirs

    def handle_hiddendirectory(self, dirname, **items):
        projorhiddendirs = []
        for subdirname, value in items.iteritems():
            projorhiddendirs += self._handle(join(dirname, subdirname), value)
        return projorhiddendirs

    def handle_project(self, dirname, **items):
        project = Project(dirname)
        for subdirname, value in items.iteritems():
            project.subdirs.append(self._handle(join(dirname, subdirname), value))
        return [project]

    def handle_pythonsrc(self, dirpath, layout):
        #print dirpath, layout
        return PythonDirectory(dirpath)

    def handle_directory(self, dirpath, ignore=[]):
        #print dirpath, ignore
        return Directory(dirpath, ignore)



def to_projectvim_format(projects):
    result = []
    for project in projects:
        entry = '{0}={1} {{'.format(project.getbasename(), project.dirpath)
        result.append(entry)
        for projsubdir in project.subdirs:
            entry = ' {0}={1} {{'.format(projsubdir.getbasename(), projsubdir.getbasename())
            result.append(entry)
            for dirpath, subdirs, files in os.walk(projsubdir.dirpath):
                files = projsubdir.filterfiles(dirpath, files)
                if projsubdir.ignoredir(dirpath, subdirs, files):
                    continue
                dirlabel = projsubdir.formatdirpath(dirpath, subdirs, files)
                dirrelpath = projsubdir.relpath(dirpath)
                entry = '  {0}={1} {{'.format(dirlabel, dirrelpath)
                result.append(entry)
                for filename in files:
                    entry = '   {0}'.format(filename)
                    result.append(entry)
                result.append('  }')
                #print dirlabel, dirrelpath
            result.append(' }')
        result.append('}')
    return '\n'.join(result)



if __name__ == "__main__":
    indexdata = open(expanduser('~/.codeprojectbrowser.js')).read()
    index = json.loads(indexdata)
    projects = Parser(index).projects

    out = to_projectvim_format(projects)
    #print out
    outfile = expanduser('~/.vimprojects')
    open(outfile, 'w').write(out)
