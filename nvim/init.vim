" ---------------------------------------------------------------------------- "
" VUNDLE MANAGER
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

filetype off

set runtimepath+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
"Plugin 'nanotech/jellybeans.vim'
Plugin 'rcisterna/sensession.vim'
Plugin 'wincent/command-t'
Plugin 'tpope/vim-git'
"Plugin 'chriskempson/base16-vim'
Plugin 'Shougo/deoplete.nvim'

call vundle#end()

" Instalacion automatica de plugins
if !isdirectory($HOME."/.vim/bundle/sensession.vim/")
    exe "PluginInstall"
endif

" Cargar configuraciones personales
source $HOME/.personal-config/vimrc

" Se recomienda utilizar una fuente para desarrolladores:
" https://www.fontyukle.net/en/Monaco.ttf

" ---------------------

" base16
" https://github.com/chriskempson/base16-vim

let base16colorspace=256
"set background=dark
"colorscheme base16-default

" ---------------------

" Command-T
" https://github.com/wincent/command-t

" cd ~/.vim/bundle/command-t/ruby/command-t
" ruby extconf.rb
" make
map <D-t> :CommandT<CR>
map <D-p> :CommandT<CR>

" ---------------------

" Deoplete
" https://github.com/Shougo/deoplete.nvim

let g:deoplete#enable_at_startup = 1
