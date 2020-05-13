let s:using_vim = !has('nvim')
let s:using_256 = 1

" ---------------------------------------------------------------------------- "
" Variables localizacion archivos

let s:vi_dir = s:using_vim ? expand('~/.vim') : expand('~/.config/nvim')
let s:plug_dir = s:vi_dir . '/plugged'

" ---------------------------------------------------------------------------- "
" Plug

" Instalacion automática
let s:plug_vim = s:vi_dir . '/autoload/plug.vim'

if empty(glob(s:plug_vim))
  let s:curl_command = 'curl -fLo ' . s:plug_vim . ' --create-dirs'
  let s:plug_source = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  call mkdir(s:plug_dir, 'p')

  echo 'Instalando Plug...'
  silent execute '!' . s:curl_command . ' ' . s:plug_source
  augroup plugAutoInstall
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

" Configuracion
call plug#begin(s:plug_dir)

  " Filetypes
  Plug 'sheerun/vim-polyglot'

  " Colorschemes
  Plug 'morhetz/gruvbox'

call plug#end()

" ---------------------------------------------------------------------------- "
" Gruvbox

if exists('g:plugs["gruvbox"]')
  if s:using_256
    " set termguicolors
    " let g:gruvbox_termcolors=256
    let g:gruvbox_termcolors=16
  else
    let g:gruvbox_termcolors=16
  endif
  " let g:gruvbox_italic=1
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_italicize_comments=1
  let g:gruvbox_invert_selection=0
  set background=dark
  colorscheme gruvbox
endif

