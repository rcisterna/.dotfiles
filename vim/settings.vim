let s:using_vim = !has('nvim')
let s:vi_dir = s:using_vim ? expand('~/.vim') : expand('~/.config/nvim')

if !isdirectory(s:vi_dir)
  call mkdir(s:vi_dir, 'p')
endif

" ---------------------------------------------------------------------------- "
" CONFIGURACIONES PERSONALES

" General
if s:using_vim
  filetype plugin indent on         " Habilitar plugins de filetype
  set nocompatible                  " No hacer vi-compatible
  set encoding=utf-8                " Codificacion UTF-8
  set history=10000                 " Por defecto 20
  set listchars=tab:\>\ ,trail:\-   " Para resaltar los <tab> y <trail>
  set hlsearch                      " Resaltar busquedas
  set incsearch                     " Busquedas incrementales
endif
set list                            " Mostrar caracteres especiales
set noexrc                          " No usar .*rc(s) externos
set nostartofline                   " No ir al primer caracter de la linea
set nowrap                          " No cortar lineas
set ignorecase                      " Ignorar case en las busquedas
set smartcase                       " Considerar case si se buscan mayusculas
set numberwidth=5                   " 9999 lineas
set nobackup                        " No crear respaldos (archivos~)
set nowritebackup                   " No sobreescribir respaldos (archivos~)
set magic                           " Regex son tratados del modo tradicinal
set hidden                          " Buffer invisible si deja de estar abierto
let g:netrw_dirhistmax = 0          " No guardar historial en .vim/.netrwhist
let g:mapleader = "\<Space>"        " Mapear <leader> a <Space>

" Interface
if s:using_vim
  if has('mouse')
    set mouse=a                     " Habilitar mouse, si existe
  endif
  set antialias                     " Desactiva el suavizado de la fuente
  set laststatus=2                  " Siempre ver la linea de status
endif
"set cursorline                     " Resaltar linea actual
"set cursorcolumn                   " Resaltar columna actual
set splitbelow                      " Ventana split abajo
set splitright                      " Ventana vsplit derecha
set scrolloff=2                     " Espacio de cursor hasta borde sup/inf
set scrolljump=5                    " Avance pagina al llegar al borde sup/inf
set number                          " Ver los numeros de línea
"set relativenumber                 " Ver numeros relativos
set showcmd                         " Mostrar comandos tecleados
set showmode                        " Mostar el modo actual de VIM
set ruler                           " Mostrar posicion del cursor siempre
set more                            " ---more---
set title                           " Titulo de la ventana
set visualbell                      " Campana visual
set noerrorbells                    " Campana visual
set cmdheight=1                     " Altura linea de comandos
set showmatch                       " Ver corchetes coincidentes

" Wild Options
set wildchar=<Tab>                  " Disparar wildmenu en linea de comandos
set wildmenu                        " Autocompletar mejorado en linea de com.
set wildmode=full                   " Modo de operar de wildmenu
" Archivos swap de vim
set wildignore=[._]*.s[a-w][a-z]
" Ignorar archivadores
set wildignore+=*.7z,*.jar,*.rar,*.zip,*.gz,*.bzip,*.bz2,*.xz,*.lzma,*.cab,*.tar
" Ignorar paquetes
set wildignore+=*.iso,*.dmg,*.xpi,*.gem,*.egg,*.deb,*.rpm,*.msi,*.msm,*.msp
" Archivos, imagenes y audio
set wildignore+=*.pdf,*.jpg,*.gif,*.png,*.wav,*.mp3,*.ogg
" Fuentes
set wildignore+=*.ttf,*.otf
" Sistemas de control de versiones
set wildignore+=[\/]\.\(git\|hg\|svn\)
" Lenguaje C
set wildignore+=*.o,*.lib,*.a,*.la,*.lo,*.dll,*.so,*.so.*,*.exe,*.out,*.app
" Lenguaje Python
set wildignore+=.Python,*.py[cod]
" OS X
set wildignore+=.DS_Store,._*,.Trashes

" Archivos
if s:using_vim
  set autoread                      " Refrescar si hay cambios
endif
set autochdir                       " Siempre usar directorio actual
set updatecount=50                  " Actualizar swp luego de 50 caracteres
set undolevels=1000                 " Tamaño maximo pila deshacer

" Tabulacion
if s:using_vim
  set autoindent                    " Autoindentar
  set backspace=indent,eol,start    " Backspace inteligente
  set smarttab                      " Tabulacion inteligente
endif
set tabstop=4                       " Tamaño tabulaciones
set expandtab                       " Tabs a espacios
set shiftwidth=4                    " Tamaño autoindentacion
set shiftround                      " Indentacion inteligente
set whichwrap+=<,>,h,l

" Sesiones (guardar y restaurar)
set sessionoptions=blank            " Ventanas vacias
set sessionoptions+=buffers         " Buffers
set sessionoptions+=curdir          " Directorio actual
set sessionoptions+=globals         " Guardar variables globales
set sessionoptions+=tabpages        " Guarda todas las paginas tab
set sessionoptions+=winsize         " Tamano de las ventanas

" Resaltar la columna 80
set colorcolumn=80

" ---------------------------------------------------------------------------- "
" STATUSLINE

set statusline=%<                           " Inicializar en blanco
set statusline+=[%n]\                       " numero de buffer
set statusline+=%t\                         " Nombre del archivo
set statusline+=%{&paste?'[paste]\ ':''}    " Modo pegar
set statusline+=%m                          " Solo lectura | modificado

set statusline+=%=                          " Separador izq/der

set statusline+=[%{&fileformat}]\           " formato del archivo (dos, unix)
set statusline+=[%{&fileencoding}]\        " codificacion del archivo
set statusline+=%y\                         " tipo de archivo (filetype)
set statusline+=%l:%c                       " linea:columna

" Setear colores para la statusline activa y no-activa
hi StatusLine ctermbg=black ctermfg=cyan guibg=black guifg=cyan
hi StatusLineNC ctermbg=black ctermfg=gray guibg=black guifg=gray

" Omnifunc
set omnifunc=syntaxcomplete#Complete
