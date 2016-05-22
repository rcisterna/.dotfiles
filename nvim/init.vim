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
augroup terminalAutoInsert
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufWinLeave,BufLeave term://* stopinsert
augroup END

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
  augroup plugAutoInstall
    autocmd!
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  augroup END
endif

" Configuracion
call plug#begin(s:plug_dir)

  " Utilidades
  Plug 'airblade/vim-rooter'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  " Autocompletado y busqueda
  Plug 'Shougo/deoplete.nvim'
  Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'

  " Filetypes
  Plug 'tpope/vim-git', { 'for' : ['git', 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail'] }
  Plug 'jwalton512/vim-blade', { 'for' : 'blade' }

  " Colorschemes
  "Plug 'chriskempson/base16-vim'
  Plug 'morhetz/gruvbox'

call plug#end()

" ---------------------
" Deoplete

if exists('g:plugs["deoplete.nvim"]')
  " Cache ctags 50MB
  " let g:deoplete#tag#cache_limit_size = 52428800
  " let g:deoplete#sources = { '_' : ['buffer', 'tag'] }
  let g:deoplete#enable_at_startup = 1
  inoremap <silent><expr> <Esc> pumvisible() ? deoplete#mappings#close_popup() : "\<Esc>"
  inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
  inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
endif

" ---------------------
" Deoplete

if exists('g:plugs["vim-gutentags"]')
  let g:gutentags_exclude = ['vendor']
endif

" ---------------------
" FZF

if exists('g:plugs["fzf.vim"]')
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
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let g:gruvbox_contrast_dark='medium'
  let g:gruvbox_invert_selection=0
  let g:gruvbox_italic=1
  colorscheme gruvbox
endif

