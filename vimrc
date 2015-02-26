" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let hostname = substitute(system('hostname'), '\n', '', '')

" Required Vundle setup
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'mitechie/pyflakes-pathogen'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'vasconcelloslf/vim-interestingwords'
Plugin 'ntpeters/vim-better-whitespace'  
Plugin 'blueyed/vim-diminactive'

call vundle#end()            " required
filetype plugin indent on    " required

" --------------------------- Normal set up ----------------------------------
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab


" Copy and Paste
noremap <C-S-x> "+x
noremap <C-S-c> "+y
noremap <C-S-p> "+P

" Bash like completion
set wildmode=longest,list,full

map Q gq " Don't use Ex mode, use Q for formatting

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Some gui options
set guioptions-=T "get rid of toolbar
set guioptions-=m "get rid of menu

" CtrlP search options
let g:ctrlp_working_path_mode = 'cra'

" Set font 
if has("gui_running")
  if has("gui_gtk2") && hostname == "lenovofedora" 
    set guifont=Inconsolata\ 10
  elseif has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Set colorscheme
se t_Co=256
set background=dark
colorscheme solarized

" vim-airline 
let g:airline_theme = 'solarized'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" To install the pre-patched font find the relevant ttf file with Powerline 
" then do:
" sudo gnome-font-viewer Ubuntu\ Mono\ derivative\ Powerline.ttf
" to install the font. Finally change the gnome-terminal to accept this.

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Change error color 
highlight clear SpellBad
highlight SpellBad term=bold cterm=bold ctermfg=White gui=standout guifg=green 

" git-gutter color hack
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=green
highlight GitGutterChange ctermfg=yellow guifg=yellow
highlight GitGutterDelete ctermfg=red guifg=red
highlight GitGutterChangeDelete ctermfg=yellow guifg=yellow

" vim-diminactive setup
let g:diminactive_use_colorcolumn = 0
let g:diminactive_use_syntax = 1

" ------------------------------ LATEX ----------------------------------------
" Compile main Latex file in directory
map <F2> :! grep "documentclass" *.tex -l \| xargs pdflatex <CR>
" Open pdf file
nmap <F12> :call system('evince ' . expand('%:r') . '.pdf') <CR>
" Latex alias
let @e = 'o\begin{equation}^M^M\end{equation}^['
" Add graphics
nnoremap <leader>g i\begin{figure}[htb]<CR>
                   \\centering<CR>
                   \\includegraphics[width=0.5\textwidth]{}<CR>
                   \\caption{}<CR>
                   \\label{fig:}<CR>
                   \\end{figure}<Esc>?{<CR>3na
" Ignored file types
set wildignore+=*.pdf,*.aux,*.bbl,*.blg,*.pyc,*.so,*.zip,*out,*ipynb,*log,*hdf5
" Latex formatting
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>


" --------------------------------- PYTHON ------------------------------------
" Python alias
let @n = 'v%S)inp.array'
let @s = 'ebvf)S]'
nnoremap <leader>p iimport matplotlib.pyplot as plt <CR>import numpy as np<Esc>


