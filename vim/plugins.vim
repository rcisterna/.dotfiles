let s:using_vim = !has('nvim')
let s:using_256 = 0

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
  Plug 'airblade/vim-rooter'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  " Autocompletado y busqueda
  if s:using_vim
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'Shougo/unite.vim' | Plug 'Shougo/unite-outline'
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'junegunn/fzf', { 'do': './install --bin' } | Plug 'junegunn/fzf.vim'
  endif

  " Filetypes
  Plug 'tpope/vim-git', { 'for' : ['git', 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail'] }
  Plug 'jwalton512/vim-blade', { 'for' : 'blade' }

  " Colorschemes
  "Plug 'chriskempson/base16-vim'
  Plug 'morhetz/gruvbox'

call plug#end()

" ---------------------------------------------------------------------------- "
" Gutentags

if exists('g:plugs["vim-gutentags"]')
  let g:gutentags_exclude = ['vendor']
endif

" ---------------------------------------------------------------------------- "
" Neocomplete

if exists('g:plugs["neocomplete.vim"]')
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  inoremap <silent><expr> <Esc> pumvisible() ? neocomplete#mappings#close_popup() : "\<Esc>"
  inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : neocomplete#mappings#manual_complete()
  inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
endif

" ---------------------------------------------------------------------------- "
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

" ---------------------------------------------------------------------------- "
" Unite

if exists('g:plugs["unite.vim"]')
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  nnoremap <C-f> :<C-u>Unite -start-insert file_rec/async:!<CR>
  nnoremap <C-p> :<C-u>Unite -start-insert file_rec/git<CR>
  nnoremap <C-b> :<C-u>Unite -start-insert buffer<CR>
  nnoremap <C-t> :<C-u>Unite -start-insert outline<CR>
endif

" ---------------------------------------------------------------------------- "
" FZF

if exists('g:plugs["fzf.vim"]')
  let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %C(blue)%an: %Creset%s %C(magenta)%cr"'
  let g:fzf_layout = { 'down': '~30%' }
  let g:fzf_buffers_jump = 1

  nnoremap <C-f> :FZF<CR>
  nnoremap <C-p> :GitFiles<CR>
  nnoremap <C-b> :Buffers<CR>
  nnoremap <C-c> :Commits<CR>
  nnoremap <C-t> :BTags<CR>
  nnoremap <C-l> :BLines<CR>
endif

" ---------------------------------------------------------------------------- "
" base16

if exists('g:plugs["base16-vim"]')
  if s:using_256
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  set background=dark
  colorscheme base16-ocean
endif

" ---------------------------------------------------------------------------- "
" Gruvbox

if exists('g:plugs["gruvbox"]')
  if s:using_256
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let g:gruvbox_termcolors=256
  else
    let g:gruvbox_termcolors=16
  endif
  let g:gruvbox_contrast_dark='medium'
  let g:gruvbox_italicize_comments=0
  let g:gruvbox_invert_selection=0
  set background=dark
  colorscheme gruvbox
endif

