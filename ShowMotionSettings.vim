"*** If your plugins are loaded after your colorscheme
highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691

"*** If your colorscheme is loaded after your plugins
function! SM_Highlight()
  highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
  highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
  highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691
endfunction
call SM_Highlight()
augroup SM_HighlightAutocmds
  autocmd!
  autocmd ColorScheme call SM_Highlight()
augroup END

"*** Highlights both big and small motions
nmap <silent> w <Plug>(show-motion-both-w)
nmap <silent> W <Plug>(show-motion-both-W)
nmap <silent> b <Plug>(show-motion-both-b)
nmap <silent> B <Plug>(show-motion-both-B)
nmap <silent> e <Plug>(show-motion-both-e)
nmap <silent> E <Plug>(show-motion-both-E)

"*** Only highlights motions corresponding to the one you typed
nmap <silent> w <Plug>(show-motion-w)
nmap <silent> W <Plug>(show-motion-W)
nmap <silent> b <Plug>(show-motion-b)
nmap <silent> B <Plug>(show-motion-B)
nmap <silent> e <Plug>(show-motion-e)
nmap <silent> E <Plug>(show-motion-E)

"Show motion for chars:  
nmap f <Plug>(show-motion-f)
nmap t <Plug>(show-motion-t)
nmap F <Plug>(show-motion-F)
nmap T <Plug>(show-motion-T)
nmap ; <Plug>(show-motion-;)
nmap , <Plug>(show-motion-,)
