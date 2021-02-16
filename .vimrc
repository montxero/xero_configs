" .vimrc
" First created: 24-10-2016	Xero 
 
" Plugins with Plug {{{
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Put plugins between the following lines and 'vundle#end()'
Plug 'vim-latex/vim-latex'
Plug 'Valloric/YouCompleteMe'
" Plug 'Yggdroot/indentLine'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/indentpython.vim'
Plug 'jpalardy/vim-slime'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'jidn/vim-dbml'
call plug#end()
"}}}

" SPACES, LINES & TABS. For files to look uniform across machines and envs {{{
set tabstop=4		"number of visual spaces per tab
set softtabstop=4	"number of spaces in tabs when editing
set shiftwidth=4	"number of spaces to use for each step of autoindent
set expandtab		"converts tabs to spaces
set textwidth=79	"sets maximum number of chars per line
set fileformat=unix	"fileformat detemines how line ending is encodded
"}}}

" Editting Settings {{{
set backspace=indent,eol,start "backspace over everything in insert mode

"disable up, down left, right arrow keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
"}}}

" UI {{{
"set number		    "show line numbers
set cursorline		"highlight current cusor line
set showcmd		    "show command in bottom bar
set wildmenu		"visual autocomplete for command menu
set showmatch		"highlight matching brackets, braces e.t.c
" set laststatus=2    "always show status line 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"}}}

" SEARCHING {{{
set incsearch		"search as characters are entered
set hlsearch		"highlight matches
"}}}

" FOLDING {{{
set foldenable	    	"enable folding
set foldmethod=syntax	"fold based on indent level
set foldlevelstart=10	"open most folds by default
autocmd Syntax c,cpp,vim,xml,html,xhtml,tex,latex setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,tex,latex normal zR
"}}}

" FILETYPE SETTINGS {{{
filetype on	    	"enable filetype detection
filetype plugin on	"load plugins for specific filetypes
filetype indent on	"apply filetype indents
let g:tex_flavor="latex"
let g:tex_conceal="" "disable concealing for tex
"}}}

" Templates {{{
autocmd BufNewFile *.py     0r ~/.vim/skeletons/skeleton.py
autocmd BufNewFile *.html   0r ~/.vim/skeletons/skeleton.html
autocmd BufNewFile *.sage     0r ~/.vim/skeletons/skeleton.sage
"}}}

" COLORSCHEMES. uncomment as needed {{{
" Badwolf
"colorscheme badwolf
"let g:badwolf_tabline = 3 "adjust tabline darkness rel to main window. 0 to 3; dark to light
"let g:badwolf_darkgutter = 1 "make gutter darker than bkgrnd. 0:= same
"}}}
"
" Functions For Added Functionality {{{
" Toggle relative number.
function! NumberToggle()
    if(&relativenumber == 1)
        set nornu
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"flag extrenous whitespace
"}}}

" Syntastic specific settings {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python'
let g:syntastic_pythnon_checkers = ['flake8', 'pylint']
let g:Syntastic_tex_checkers = ['lacheck']
"}}}

" YouCompleteMe settings {{{
let g:ycm_autoclose_preview_window_after_completion=1
"}}}
"
" Vim-Slime Settings {{{
let g:slime_target = "screen"
let g:sime_paste = "$HOME/.slime_paste"
"}}}
"
" vim:foldmethod=marker:foldlevel=0
" 
