" Vim syntax file
" Language:	Django JavaScript template

if !exists("main_syntax")
  let main_syntax = 'javascript'
endif

runtime! syntax/django.vim
runtime! syntax/javascript.vim
unlet b:current_syntax

syn cluster djangoBlocks add=djangoTagBlock,djangoVarBlock,djangoComment,djangoComBlock

syn region djangoTagBlock start="{%" end="%}" contains=djangoStatement,djangoFilter,djangoArgument,djangoTagError display containedin=ALLBUT,@djangoBlocks
syn region djangoVarBlock start="{{" end="}}" contains=djangoFilter,djangoArgument,djangoVarError display containedin=ALLBUT,@djangoBlocks
syn region djangoComment start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}" contains=djangoTodo containedin=ALLBUT,@djangoBlocks
syn region djangoComBlock start="{#" end="#}" contains=djangoTodo containedin=ALLBUT,@djangoBlocks

let b:current_syntax = "jsdjango"
