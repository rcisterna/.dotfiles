let s:nvim_dir = expand("~/.config/nvim")

" ---------------------
" base16

let s:base16_readme = expand(s:nvim_dir . '/plugged/base16-vim/README.md')

function! WhenBase16Ready(info)
  set background=dark
  colorscheme base16-ocean
endfunction

" ---------------------
" Deoplete

let g:deoplete#enable_at_startup = 1

" ---------------------
" Plug

" Instalacion automática
let s:plug_vim = s:nvim_dir . '/autoload/plug.vim'

if empty(glob(s:plug_vim))
  let s:curl_command = "curl -fLo " . s:plug_vim . " --create-dirs"
  let s:plug_source = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  echo "Instalando Plug..."
  silent execute "!" . s:curl_command . " " . s:plug_source
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Configuracion
call plug#begin(s:nvim_dir . '/plugged')

Plug 'rcisterna/sensession.vim'
Plug 'tpope/vim-git'
Plug 'chriskempson/base16-vim', { 'do': function('WhenBase16Ready') }
Plug 'Shougo/deoplete.nvim'

call plug#end()

if filereadable(s:base16_readme)
  call WhenBase16Ready(s:base16_readme)
endif

" ---------------------
" Configuraciones personales

source ~/.personal-config/vimrc

