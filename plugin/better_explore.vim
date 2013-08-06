" Texplore, Explore, Sexplore and Vexplore. These use whatever directory
" lister we have installed instead of forcing the default, which means that we
" user NERD_tree when available.

command! -nargs=0 TabExplore :tabedit %:h
command! -nargs=0 CurExplore :edit %:h
command! -nargs=0 SplitExplore :split %:h
command! -nargs=0 VsplitExplore :vsplit %:h
