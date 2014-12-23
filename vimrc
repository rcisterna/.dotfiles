" ---------------------------------------------------------------------------- "
" CONFIGURACIONES PERSONALES

" Visualizacion
" Monochrome (no requiere configuracion)
" https://github.com/joakin/vim-monochrome
syntax enable                       " Colorear la sintaxis
colorscheme monochrome

" General
filetype plugin indent on           " Habilitar plugins de filetype
set history=700                     " Por defecto 20
set list                            " Mostrar caracteres especiales
set listchars=tab:\>\               " Para resaltar los <tab>
set nocompatible                    " No hacer vi-compatible
set noexrc                          " No usar .*rc(s) externos
set nostartofline                   " No ir al primer caracter de la linea
set nowrap                          " No cortar lineas
set ignorecase                      " Ignorar case en las busquedas
set numberwidth=7                   " 99999 lineas
set nobackup                        " No crear respaldos (archivos~)
set nowritebackup                   " No sobreescribir respaldos (archivos~)
set incsearch                       " Busquedas incrementales
set hlsearch                        " Resaltar busquedas
set antialias                       " Desactiva el suavizado de la fuente
set magic                           " Dejar la magia habilitada para regex
let g:netrw_dirhistmax = 0          " No guardar historial en .vim/.netrwhist

" Interface
set encoding=utf-8                  " Codificacion UTF-8
set so=2                            " Espacio de cursor hasta borde sup/inf
set number                          " Ver los numeros de línea
set relativenumber                  " Ver numeros relativos
set showcmd                         " Mostrar comandos tecleados
set showmode                        " Mostar el modo actual de VIM
set ruler                           " Mostrar posicion del cursor siempre
set more                            " ---more---
set title                           " Titulo de la ventana
set visualbell                      " Campana visual
set noerrorbells                    " Campana visual
set wildmenu                        " Autocompletar mejorado
set wildignore=.bak,.pyc,.o,.,      " Ignorar tipos de archivo
              \.pdf,.jpg,.gif,.png,
              \.ttf,.otf,
              \a,.so
set wildmode=list:longest           " Lista larga de wildome
set hidden                          " Buffer invisible si se abandona
set laststatus=2                    " Siempre ver la linea de status
set cmdheight=1                     " Altura linea de comandos
set showmatch                       " Ver corchetes coincidentes
if has('mouse')
  set mouse=a                       " Habilitar mouse, si existe
endif
if has("gui_macvim")
  set guioptions-=r                 " Eliminar scrollbar en MacVim
endif
"set cursorline                     " Resaltar linea actual
"set cursorcolumn                   " Resaltar columna actual

" Archivos
set autochdir                       " Siempre usar directorio actual
set autoread                        " Refrescar si hay cambios
set updatecount=50                  " Actualizar swp luego de 50 caracteres
set undolevels=1000                 " Tamaño maximo pila deshacer

" Pliegues
set foldcolumn=0                    " Ancho 0 en la columna de pliegue
set foldmethod=indent               " Plegar usando indentacion
set foldnestmax=4                   " Maximo 4 pliegues anidados
set nofoldenable                    " Todos los pliegues comienzan abiertos

" Tabulacion
set tabstop=4                       " Tamaño tabulaciones
set expandtab                       " Tabs a espacios
set smarttab                        " Tabulacion inteligente
set shiftwidth=4                    " Tamaño autoindentacion
set shiftround                      " Indentacion inteligente
set autoindent                      " Autoindentar
set backspace=eol,start,indent      " Backspace inteligente
set whichwrap+=<,>,h,l

" Resaltar la columna 80
set colorcolumn=80
highlight ColorColumn ctermbg=8

if has("autocmd")

  augroup vimrcEx
  au!
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

  " Opciones especiales de tabulación para tipos de archivo
  autocmd FileType vim
    \ setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType c,cpp,make
    \ setlocal tabstop=8 shiftwidth=8 noexpandtab
  autocmd FileType php
    \ setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType python
    \ setlocal tabstop=4 shiftwidth=4 expandtab

  " Cantidad de caracteres por línea soportados en archivos de texto
  autocmd FileType text,markdown,vim
    \ setlocal textwidth=80

  " Eliminar espacios en blanco al fin de linea al guardar
  autocmd BufWritePre * :%s/\s\+$//e

  " Abrir explorador de archivos si no se especifica archivo al inicio
  " autocmd VimEnter * call Explorador()
  " autocmd StdinReadPre * let s:std_in=1
  " function! Explorador()
  "   if argc() == 0 && !exists("s:std_in") | Explore | end
  " endfunction

endif " has("autocmd")

" ---------------------------------------------------------------------------- "
" STATUSLINE

set statusline=%<                           " Inicializar en blanco
set statusline+=[%n]\                       " numero de buffer
set statusline+=%t\                         " Nombre del archivo
set statusline+=%{&paste?'[paste]\ ':''}    " Modo pegar
set statusline+=%m                          " Solo lectura | modificado

set statusline+=%=                          " Separador izq/der

set statusline+=[%{&fileformat}]\           " formato del archivo (dos, unix)
"set statusline+=[%{&fileencoding}]\        " codificacion del archivo
set statusline+=%y\                         " tipo de archivo (filetype)
set statusline+=%l:%c                       " linea:columna

" Setear colores para la statusline activa y no-activa
" hi StatusLine ctermbg=black ctermfg=cyan guibg=black guifg=cyan
" hi StatusLineNC ctermbg=black ctermfg=gray guibg=black guifg=gray

" ---------------------------------------------------------------------------- "
" ATAJOS DE TECLADO PERSONALES

" (INSERT) Autocerrar parentesis y comillas
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

" Cambio de buffers
nnoremap <C-TAB> :bnext<cr>
nnoremap <C-S-TAB> :bprev<cr>

" Usar Q para dar formato al texto
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Ver las modificaciones del archivo actual (antes de guardar)
if !exists(":DiffOrig")
  command DiffOrig vert new
      \ | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
  noremap <D-d> :DiffOrig<cr>
endif