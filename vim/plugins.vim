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
  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'

  " Autocompletado, linters y busqueda
  Plug 'neomake/neomake'
  if s:using_vim
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/vimproc.vim', {'do': 'make'}
    Plug 'Shougo/unite.vim' | Plug 'Shougo/unite-outline'
  else
    Plug 'junegunn/fzf', {'do': './install --bin'} | Plug 'junegunn/fzf.vim'
    Plug 'Shougo/deoplete.nvim'
    " Deoplete para rust
    let rust_dir = g:plug_home . '/rust/'
    let rust_repo_action = isdirectory(rust_dir) ? 'git -C ' . rust_dir . ' pull' : 'git clone --depth=1 https://github.com/rust-lang/rust.git ' . rust_dir
    Plug 'phildawes/racer', {'for': 'rust', 'do': rust_repo_action . ' & cargo build --release'} | Plug 'sebastianmarkow/deoplete-rust', {'for': 'rust'}
  endif

  " Filetypes
  Plug 'sheerun/vim-polyglot'

  " Colorschemes
  "Plug 'chriskempson/base16-vim'
  Plug 'morhetz/gruvbox'

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
" Closetags

if exists('g:plugs["neomake"]')
  autocmd! BufWritePost * Neomake
endif

" ---------------------------------------------------------------------------- "
" Neocomplete

if exists('g:plugs["neocomplete.vim"]')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  imap <leader>n <C-n>
  imap <leader>p <C-p>
  " inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-D>"
endif

" ---------------------------------------------------------------------------- "
" Deoplete

if exists('g:plugs["deoplete.nvim"]')
  " Cache ctags 100MB
  " let g:deoplete#tag#cache_limit_size = 104857600
  let g:deoplete#sources = {}
  " let g:deoplete#sources._ = ['buffer', 'tag']
  let g:deoplete#enable_at_startup = 1
  inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-D>"
endif

" ---------------------------------------------------------------------------- "
" Rust for Deoplete

if exists('g:plugs["deoplete-rust"]')
  let g:deoplete#sources#rust#racer_binary = g:plug_home . '/racer/target/release/racer'
  let g:deoplete#sources#rust#rust_source_path = g:plug_home . '/rust/src'
endif

" ---------------------------------------------------------------------------- "
" Unite

if exists('g:plugs["unite.vim"]')
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
  nnoremap <leader>f :<C-u>Unite -start-insert file_rec/async:!<CR>
  nnoremap <leader>p :<C-u>Unite -start-insert file_rec/git<CR>
  nnoremap <leader>b :<C-u>Unite -start-insert buffer<CR>
  nnoremap <leader>t :<C-u>Unite -start-insert outline<CR>
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
" base16

if exists('g:plugs["base16-vim"]')
  if s:using_256
    set termguicolors
  endif
  set background=dark
  colorscheme base16-ocean
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
  let g:gruvbox_italic=1
  let g:gruvbox_contrast_dark='medium'
  let g:gruvbox_italicize_comments=1
  let g:gruvbox_invert_selection=0
  set background=dark
  colorscheme gruvbox

  " " dark0 + gray
  " let g:terminal_color_0 = "#282828"
  " let g:terminal_color_8 = "#928374"

  " " neurtral_red + bright_red
  " let g:terminal_color_1 = "#cc241d"
  " let g:terminal_color_9 = "#fb4934"

  " " neutral_green + bright_green
  " let g:terminal_color_2 = "#98971a"
  " let g:terminal_color_10 = "#b8bb26"

  " " neutral_yellow + bright_yellow
  " let g:terminal_color_3 = "#d79921"
  " let g:terminal_color_11 = "#fabd2f"

  " " neutral_blue + bright_blue
  " let g:terminal_color_4 = "#458588"
  " let g:terminal_color_12 = "#83a598"

  " " neutral_purple + bright_purple
  " let g:terminal_color_5 = "#b16286"
  " let g:terminal_color_13 = "#d3869b"

  " " neutral_aqua + faded_aqua
  " let g:terminal_color_6 = "#689d6a"
  " let g:terminal_color_14 = "#8ec07c"

  " " light4 + light1
  " let g:terminal_color_7 = "#a89984"
  " let g:terminal_color_15 = "#ebdbb2"
endif

