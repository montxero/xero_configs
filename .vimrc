" .vimrc
" created: 24-10-2016	Xero 
" last modified: 15-01-2018 Xero
 
" Vundle Setup {{{
" template: ~/.vim/Bundles/vundle_tplt
" compulsary commands
set nocompatible	"breaks vi compatibility
filetype off		" disables filetype recognition.
set rtp+=/home/xero/.vim/bundle/Vundle.vim	"include vundle in runtime path
call vundle#begin()	"initialise vundle
" Put plugins between the following lines and 'vundle#end()'
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-syntastic/syntastic'
"Plugin 'vim-scripts/indentpython.vim'
call vundle#end()
"}}}

" COLOURS eyecandy {{{
set t_Co=256		"enable 256 colours. Needed for some colorschemes
syntax enable		"enable syntax highlighting by colour
set background=dark	"dark background
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
"}}}

" UI {{{
set number		    "show line numbers
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
set foldmethod=indent	"fold based on indent level
set foldlevelstart=10	"open most folds by default
"}}}

" FILETYPE SETTINGS {{{
filetype on	    	"enable filetype detection
filetype plugin on	"load plugins for specific filetypes
filetype indent on	"apply filetype indents
let g:tex_conceal=""    "disable concealing in latex
augroup filetypedetect
    au BufRead,BufNewFile *.sage setfiletype python "associate *.sage with python filetype
augroup END
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
"}}}

" Syntastic specific settings {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_pythnon_checkers = ['flakes8', 'pylint']
let g:Syntastic_tex_checkers = ['lacheck']
"
" vim:foldmethod=marker:foldlevel=0
" 
