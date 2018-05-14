set inccommand=split                " Reemplazo incremental
set number                          " Ver los numeros de línea
set relativenumber                  " Ver numeros relativos
set splitbelow                      " Ventana split abajo
set splitright                      " Ventana vsplit derecha
colorscheme pablo                   " Color por defecto
set background=dark                 " Indicar fondo oscuro


" ---------------------------------------------------------------------------- "
" STATUSLINE

set statusline=%<                           " Inicializar en blanco
set statusline+=[%n]\                       " numero de buffer
set statusline+=%t\                         " Nombre del archivo
set statusline+=%{&paste?'[paste]\ ':''}    " Modo pegar
set statusline+=%m                          " Solo lectura | modificado

set statusline+=%=                          " Separador izq/der

set statusline+=[%{&fileformat}]\           " formato del archivo (dos, unix)
set statusline+=[%{&fileencoding}]\         " codificacion del archivo
set statusline+=%y\                         " tipo de archivo (filetype)
set statusline+=%l:%c                       " linea:columna

" Setear colores para la statusline activa y no-activa
hi StatusLine ctermbg=black ctermfg=cyan guibg=black guifg=cyan
hi StatusLineNC ctermbg=black ctermfg=gray guibg=black guifg=gray
