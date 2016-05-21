" ---------------------
" Variables localizacion archivos

let s:nvim_dir = expand('~/.config/nvim')
let s:plug_dir = s:nvim_dir . '/plugged'

" ---------------------
" Configuraciones personales

source ~/.dotfiles/vimrc

" ---------------------
" Configuraciones modo terminal

" Entrar a buffer de terminal en modo insert, y salir en modo normal
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufWinLeave,BufLeave term://* stopinsert

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

" ---------------------
" Plug

" Instalacion automática
let s:plug_vim = s:nvim_dir . '/autoload/plug.vim'

if empty(glob(s:plug_vim))
  let s:curl_command = 'curl -fLo ' . s:plug_vim . ' --create-dirs'
  let s:plug_source = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  call mkdir(s:plug_dir, 'p')

  echo 'Instalando Plug...'
  silent execute '!' . s:curl_command . ' ' . s:plug_source
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Configuracion
call plug#begin(s:plug_dir)

Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-rooter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
"Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-git'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jwalton512/vim-blade'

call plug#end()

" ---------------------
" Deoplete

let g:deoplete#enable_at_startup = 1

" ---------------------
" FZF

if exists('g:plugs["deoplete.nvim"]')
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %C(blue)%an: %Creset%s %C(magenta)%cr"'
  let g:fzf_layout = { 'down': '~30%' }
  let g:fzf_buffers_jump = 1

  nnoremap <C-f> :FZF<cr>
  nnoremap <C-p> :GitFiles<cr>
  nnoremap <C-b> :Buffers<cr>
  nnoremap <C-c> :Commits<cr>
  nnoremap <C-t> :BTags<cr>
  nnoremap <C-l> :BLines<cr>
endif

" ---------------------
" base16

if exists('g:plugs["base16-vim"]')
  set background=dark
  colorscheme base16-ocean
endif

" ---------------------
" Gruvbox

if exists('g:plugs["gruvbox"]')
  set background=dark
  let g:gruvbox_italic=1
  colorscheme gruvbox
endif

