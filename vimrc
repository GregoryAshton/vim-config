" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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
Plugin 'boucherm/ShowMotion'

call vundle#end()            " required
filetype plugin indent on    " required

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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

" ShowMotion stuff
source /home/greg/.vim/ShowMotionSettings.vim


" Some gui options
set guioptions-=T "get rid of toolbar
set guioptions-=m "get rid of menu

" Set working directory to open file
"autocmd BufEnter * silent! lcd %:p:h

" CtrlP search options
let g:ctrlp_working_path_mode = 'cra'

" Change font size with f* keys
"map <F9> :set guifont=Lucida_Console:h9:cANSI<CR>
"map <F10> :set guifont=Lucida_Console:h10:cANSI<CR>
"map <F11> :set guifont=Lucida_Console:h11:cANSI<CR>

" Set font in GVim to use Powerline patched version
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Set colorscheme
syntax enable
set background=dark
colorscheme solarized
se t_Co=256

" vim-airline 
let g:airline_theme = 'solarized'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" To install the pre-patched font find the relevant ttf file with Powerline 
" then do:
" sudo gnome-font-viewer Ubuntu\ Mono\ derivative\ Powerline.ttf
" to install the font. Finally change the gnome-terminal to accept this.

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent off

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Other 
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"autocmd FileType py,c highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"autocmd FileType py,c match OverLength /\%81v.*/
"highlight OverLength ctermbg=darkred ctermfg=white guibg=red
"match OverLength /\%81v.*/

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Tab Control (others)
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt


syntax on 
filetype on
filetype plugin indent on    " enable loading indent file for filetype

" Turn of smartindento
set nosmartindent

" Change error color 
highlight clear SpellBad
highlight SpellBad term=bold cterm=bold ctermfg=White gui=standout guifg=green 

" git-gutter color hack
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=green
highlight GitGutterChange ctermfg=yellow guifg=yellow
highlight GitGutterDelete ctermfg=red guifg=red
highlight GitGutterChangeDelete ctermfg=yellow guifg=yellow

filetype plugin on

" Vim-latex
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_MultipleCompileFormats='pdf, aux'
"let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'
"let g:Imap_FreezeImap=1 " Switch off magic

" Compile main Latex file in directory
map <F2> :! grep "documentclass" *.tex -l \| xargs pdflatex <CR>

" Open pdf file
nmap <F12> :call system('evince ' . expand('%:r') . '.pdf') <CR>

"augroup BgHighlight
"    autocmd!
"    autocmd WinEnter * set cul
"    autocmd WinLeave * set nocul
"augroup END
"

" Python alias
let @n = 'v%S)inp.array'
let @s = 'ebvf)S]'

" Latex alias
let @e = 'o\begin{equation}^M^M\end{equation}^['

" Copy and Paste
noremap <C-S-x> "+x
noremap <C-S-c> "+y
noremap <C-S-p> "+P

" Latex formatting
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

" Bash like completion
set wildmode=longest,list,full

" Ignored file types
set wildignore+=*.pdf,*.aux,*.bbl,*.blg,*.pyc,*.so,*.zip,*out,*ipynb,*log,*hdf5

" Setting word jumps
"set iskeyword+=,,.

" Keystroke to add imports
nnoremap <leader>p iimport matplotlib.pyplot as plt <CR>import numpy as np<Esc>

" Add graphics
nnoremap <leader>g i\begin{figure}[htb]<CR>
                   \\centering<CR>
                   \\includegraphics[width=0.5\textwidth]{}<CR>
                   \\caption{}<CR>
                   \\label{fig:}<CR>
                   \\end{figure}<Esc>?{<CR>3na
