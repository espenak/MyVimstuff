syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
hi def link cppFuncDef Special

syn region cppCerr start="std::cerr" end=";"
syn region cppCerr start="cerr" end=";"
hi def link cppCerr Error

syn region cppCout start="std::cout" end=";"
syn region cppCout start="cout" end=";"
hi def link cppCout Debug
