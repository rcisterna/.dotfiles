let s:using_vim = !has('nvim')

" ---------------------------------------------------------------------------- "
" MAPEOS

" Centrado automático
nnoremap G Gzz
nmap n :norm! nzz<cr>
nmap N :norm! Nzz<cr>

" Ctags
nnoremap <silent> <leader>i :execute 'tag ' . expand("<cword>")<cr>
nnoremap <silent> <leader>o :execute 'pop'<cr>

" Usar Q para dar formato al texto
map Q gq

function! OpenMarked()
  if &filetype == 'markdown'
    silent execute '!open -a "Marked 2.app" "%:p"'
  else
    echo 'El archivo no es de tipo markdown'
  endif
endfunction

" Abrir archivos markdown con Marked 2
nnoremap <silent><leader>m :call OpenMarked()<CR>

" Movimiento entre ventanas natural
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Movimieno de ventanas
nnoremap <leader>H <C-w>H
nnoremap <leader>J <C-w>J
nnoremap <leader>K <C-w>K
nnoremap <leader>L <C-w>L

" Cambio de tamaño de ventanas
nnoremap <leader>= <C-w>=
nnoremap <leader>_ <C-w>_
nnoremap <leader>\| <C-w>\|

" ---------------------------------------------------------------------------- "
" MODO TERMINAL

if !s:using_vim
  " Entrar a buffer de terminal en modo insert, y salir en modo normal
  augroup terminalAutoInsert
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufWinLeave,BufLeave term://* stopinsert
  augroup END

  " Abrir terminal con tt, cerrar con <Esc>
  nnoremap <silent> tt :below 13sp term://bash<cr>
  tnoremap <silent> <C-w>q <C-\><C-n>:bdelete!<cr>

  " Cambiar de ventana
  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l

  " Modificar a tamaños estandar de ventana
  tnoremap <C-w>= <C-\><C-n><C-w>=i
  tnoremap <C-w>_ <C-\><C-n><C-w>_i

  " Aumentar o disminuir el tamaño de la ventana
  tnoremap <C-w>- <C-\><C-n>3<C-w>-i
  tnoremap <C-w>+ <C-\><C-n>3<C-w>+i
endif
