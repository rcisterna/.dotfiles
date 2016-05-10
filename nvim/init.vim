" ---------------------
" Vundle

filetype off
let s:nvim_dir=expand("~/.config/nvim")

let s:vundle_installed=0
if !filereadable(s:nvim_dir . '/bundle/Vundle.vim/README.md')
  echo "Instalando Vundle..."
  let s:vundle_repo="git clone https://github.com/VundleVim/Vundle.vim.git"
  silent execute "!" . s:vundle_repo . " " . s:nvim_dir . "/bundle/Vundle.vim"
  let s:vundle_installed=1
endif

set runtimepath+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin(s:nvim_dir . '/bundle')

Plugin 'VundleVim/Vundle.vim'
"Plugin 'nanotech/jellybeans.vim'
Plugin 'rcisterna/sensession.vim'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-git'
Plugin 'chriskempson/base16-vim'
Plugin 'Shougo/deoplete.nvim'

call vundle#end()

if s:vundle_installed
  echo "Instalando plugins..."
  silent execute "PluginInstall"
  echo "Plugins instalados. Tal vez necesite ejecutar ':UpdateRemotePlugins'."
endif

" ---------------------
" Configuraciones personales

source ~/.personal-config/vimrc

" ---------------------
" base16

"let base16colorspace=256
set background=dark
colorscheme base16-default

" ---------------------
" Command-T

" cd ~/.vim/bundle/command-t/ruby/command-t
" ruby extconf.rb
" make
map <D-t> :CommandT<CR>
map <D-p> :CommandT<CR>

" ---------------------
" Deoplete

let g:deoplete#enable_at_startup = 1

