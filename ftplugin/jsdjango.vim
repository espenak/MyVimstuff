" Vim filetype plugin file
" Language:	Django Javascript template

" Only use this filetype plugin when no other was loaded.
if exists("b:did_ftplugin")
  finish
endif

" Use JavaScript and Django template ftplugins.
runtime! ftplugin/javascript.vim
runtime! ftplugin/django.vim
