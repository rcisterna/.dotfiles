" ---------------------
" Variables localizacion archivos

let s:nvim_dir = expand("~/.config/nvim")
let s:plug_dir = s:nvim_dir . '/plugged'

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

function! WhenBase16Ready(info)
  set background=dark
  colorscheme base16-ocean
endfunction

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
Plug 'kassio/neoterm'
Plug 'tpope/vim-git'
Plug 'chriskempson/base16-vim', { 'do': function('WhenBase16Ready') }

call plug#end()

if filereadable(s:base16_readme)
  call WhenBase16Ready(s:base16_readme)
endif

" ---------------------
" Configuraciones personales

source ~/.personal-config/vimrc

" ---------------------
" Configuraciones modo terminal

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

nnoremap <silent> tt :call neoterm#open()<cr>

tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <silent> <C-d> <C-\><C-n>:call neoterm#close()<cr>
