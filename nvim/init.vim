" ---------------------
" Variables localizacion archivos

let s:nvim_dir = expand("~/.config/nvim")
let s:plug_dir = s:nvim_dir . '/plugged'

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
call plug#begin(s:plug_dir)

Plug 'Shougo/deoplete.nvim'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-git'
Plug 'chriskempson/base16-vim'

call plug#end()

" ---------------------
" Deoplete

let g:deoplete#enable_at_startup = 1

" ---------------------
" FZF

let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %C(blue)%an: %Creset%s %C(magenta)%cr"'
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_buffers_jump = 1

nnoremap <C-a> :FZF<cr>
nnoremap <C-p> :GitFiles<cr>
nnoremap <C-b> :Buffers<cr>
nnoremap <C-l> :BLines<cr>
nnoremap <C-c> :Commits<cr>

" ---------------------
" base16

let s:base16_readme = expand(s:plug_dir . '/base16-vim/README.md')

if filereadable(s:base16_readme)
  set background=dark
  colorscheme base16-ocean
endif

" ---------------------
" Configuraciones modo terminal

" Entrar a buffer de terminal en modo insert, y salir en modo normal
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufWinLeave,BufLeave term://* stopinsert

" Abrir terminal con tt
nnoremap <silent> tt :below 10sp term://bash<cr>

" Cambiar de ventana desde terminal de la forma tradicional
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>= <C-\><C-n><C-w>=i
tnoremap <C-w>_ <C-\><C-n><C-w>_i
tnoremap <C-w>_ <C-\><C-n><C-w>_i
tnoremap <C-w>- <C-\><C-n><C-w>-i
tnoremap <C-w>+ <C-\><C-n><C-w>+i
tnoremap <silent> <C-w>h <C-\><C-n>:hide<cr>

" ---------------------
" Configuraciones personales

source ~/.dotfiles/vimrc
