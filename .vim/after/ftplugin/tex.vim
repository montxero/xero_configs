"This script is the file type plugin for .tex files 
"It configures the behavior of vim when editing tex files
" Added by Xero
"

set spell
set spelllang=en
set fileformat=unix
set fileencodings=utf-8
set textwidth=120
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nonumber
let g:tex_conceal=""    "disable concealing in latex

"let g:tex_conceal=""    "disable concealing in latex
let g:tex_flavor = "latex"

"Enable forward searches in dvi files. Requires vim-latex
let g:Tex_CompileRule_dvi = 'latex -src-specials -interaction=nonstopmode $*'
"
"Automatically complie and refresh viewer on write: depends on vim-latex
"au BufWritePost *.tex silent call Tex_RunLatex()
"au BufWritePost *.tex silent !pkill -USR1 xdvi.bin
"TCTarget dvi
