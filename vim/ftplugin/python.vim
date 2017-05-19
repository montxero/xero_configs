"This script is the file type plugin for python
"It configures the behavior of vim when editing python files
"This configuration applies to every file Vim detects as a Python file
"including those with file names that don't end with .py
" Added by Xero
"

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
set autoindent
set fileformat=unix
