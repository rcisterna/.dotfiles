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

  " Utilidades
  " Plug 'ludovicchabant/vim-gutentags'

  " Cerrado automático de paréntesis, tags, comentarios, y facil intercambio
  " Plug 'jiangmiao/auto-pairs'
  " Plug 'alvan/vim-closetag'
  " Plug 'tpope/vim-commentary'
  " Plug 'tpope/vim-surround'

  " Autocompletado, linters y busqueda
  " Plug 'junegunn/fzf', {'do': './install --bin'} | Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Filetypes
  Plug 'sheerun/vim-polyglot'

  " Colorschemes
  " Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'

  " Intellisense
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ---------------------------------------------------------------------------- "
" Autopairs

if exists('g:plugs["auto-pairs"]')
  let g:AutoPairsFlyMode = 1
endif

" ---------------------------------------------------------------------------- "
" Closetags

if exists('g:plugs["vim-closetag"]')
	let g:closetag_filenames = "*.blade.php,*.html,*.xhtml,*.phtml"
endif

" ---------------------------------------------------------------------------- "
" Gutentags

if exists('g:plugs["vim-gutentags"]')
  " Exclude 'vendor' directory
  " let g:gutentags_ctags_exclude = ['vendor']
endif

" ---------------------------------------------------------------------------- "
" FZF

if exists('g:plugs["fzf.vim"]')
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %C(blue)%an: %Creset%s %C(magenta)%cr"'
  let g:fzf_layout = { 'down': '~30%' }
  let g:fzf_buffers_jump = 1

  nnoremap <leader>f :FZF<CR>
  nnoremap <leader>p :GitFiles<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>t :BTags<CR>
  nnoremap <leader>c :BLines<CR>
endif

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

" ---------------------------------------------------------------------------- "
" Nord

if exists('g:plugs["nord-vim"]')
  colorscheme nord
endif

