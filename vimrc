" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

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

" Set colorscheme in gvim
if has("gui_running")
  colorscheme github
else
 colorscheme delek
endif

" Octave syntax
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END 

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

" http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide#intro
filetype off
execute pathogen#incubate()
execute pathogen#helptags()
syntax on 
filetype on
filetype plugin indent on    " enable loading indent file for filetype

" Folding for python
nnoremap <space> za
set foldmethod=indent
set foldlevel=99

" Nerd tree
map <leader>n :NERDTreeToggle<CR>

" Turn of smartindento
set nosmartindent

" Change error color 
highlight clear SpellBad
highlight SpellBad term=bold cterm=bold ctermfg=green gui=standout guifg=green 

filetype plugin on

" Pydiction
"let g:pydiction_location = '/home/greg/.vim/bundle/pydiction/complete-dict'

" Vim-latex
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'
let g:Imap_FreezeImap=1 " Switch off magic

" Compile main Latex file in directory
map <F2> :! grep "documentclass" *.tex -l \| xargs pdflatex <CR>

"augroup BgHighlight
"    autocmd!
"    autocmd WinEnter * set cul
"    autocmd WinLeave * set nocul
"augroup END
"

" Python alias
let @n = 'v%S)inp.array'
let @s = 'ebvf)S]'

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
set wildignore+=*.pdf,*.aux,*.bbl,*.blg
set wildignore+=*.pyc,*.so
