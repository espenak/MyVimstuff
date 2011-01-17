python << EOF
import vim
import os.path
import sys

class AlternateFiles(object):
	def __init__(self):
		self.header_ext = (".h", ".hpp", ".hxx")
		self.source_ext = (".c", ".cxx", ".cpp", ".cc", ".C")

	def _error(self, msg):
		print >> sys.stderr, msg

	def _relpath(self, path):
		bufdir = os.path.dirname(vim.current.buffer.name)
		return os.path.normpath(os.path.join(bufdir, path))

	def _searchForFile(self, dirnames, fileprefix, extensions):
		for dn in dirnames:
			relpath = self._relpath(dn)
			if os.path.exists(relpath):
				for dirname, dirnames, filenames in os.walk(relpath):
					for filename in filenames:
						path = os.path.join(dirname, filename)
						prefix, ext = os.path.splitext(filename)
						if prefix == fileprefix and ext in extensions:
							return path
		return None

	def _openFile(self, prefix, dirnames, extensions):
		path = self._searchForFile(dirnames, prefix, extensions)
		if path == None:
			self._error("No alternate file found")
			return
		if vim.eval('buflisted("%s")' % path) == "1":
			bufname = vim.eval('bufname("%s")' % path)
			vim.command("b %s" % bufname)
		else:
			vim.command("edit %s" % path)

	def findAlt(self):
		filename = vim.current.buffer.name
		prefix, ext = os.path.splitext(os.path.basename(filename))
		if ext in self.header_ext:
			dirnames = ['', '../', '../src/', '../../src/']
			self._openFile(prefix, dirnames, self.source_ext)
		elif ext in self.source_ext:
			dirnames = ['', 'include/', '../include/', '../../include']
			self._openFile(prefix, dirnames, self.header_ext)
		else:
			self._error("Your current file in not among the configured filetypes for altfiles: %s" %
				",".join(self.header_ext+self.source_ext))

altfiles = AlternateFiles()

EOF

fun! SetupAltFile()
	nnoremap <Leader>af :py altfiles.findAlt()<CR>
endfun

au BufNewFile,BufRead *.h call SetupAltFile()
au BufNewFile,BufRead *.hpp call SetupAltFile()
au BufNewFile,BufRead *.hcc call SetupAltFile()
au BufNewFile,BufRead *.c call SetupAltFile()
au BufNewFile,BufRead *.cxx call SetupAltFile()
au BufNewFile,BufRead *.cpp call SetupAltFile()
au BufNewFile,BufRead *.cc call SetupAltFile()
au BufNewFile,BufRead *.C call SetupAltFile()
