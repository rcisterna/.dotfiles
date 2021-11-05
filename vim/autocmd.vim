let s:using_vim = !has('nvim')

" ---------------------------------------------------------------------------- "
" AUTOCMD

" Al editar un archivo, siempre ir a la última posición conocida del cursor, a
" menos que la posición sea inválida, o que el archivo haya sido abierto por un
" evento (por ejemplo, arrastrar un archivo a gvim).
augroup setLastCursorPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif
augroup END

" Cantidad de caracteres por línea soportados en archivos de texto
augroup wrapText
  autocmd!
  autocmd FileType text,markdown,vim setlocal textwidth=80
augroup END

" Eliminar espacios en blanco al fin de linea al guardar
augroup deleteTrailAtSave
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" Linea actual sólo en la ventana activa
augroup diffentiateCurrentBuffer
  autocmd!
  autocmd InsertLeave * setlocal cursorline
  autocmd InsertEnter * setlocal nocursorline

  autocmd BufEnter,WinEnter * setlocal cursorline relativenumber
  autocmd BufLeave,WinLeave * setlocal nocursorline norelativenumber
augroup END

