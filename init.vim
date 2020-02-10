if v:progname == 'vi'
  set noloadplugins " if vi is being used, don't use plugins
endif

" Plugins
" {{{
" The next lines is to ensure vim plug is installd
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

" Utilities
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" detect indentation of the openned file
Plug 'tpope/vim-sleuth'

" Vimfiler <leader>b
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'

" Colors & UI
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'myusuf3/numbers.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'qpkorr/vim-bufkill'
Plug 'roman/golden-ratio'
Plug 'farmergreg/vim-lastplace' " reopen files at your last edit position
" Plug 'wellle/context.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-obsession'
Plug 'machakann/vim-highlightedyank'

" Code utilities
Plug 'editorconfig/editorconfig-vim'
" insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'dense-analysis/ale'

" highlights the XML/HTML tags that enclose your cursor location
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml', 'xhtml', 'vue']}

" Languages & Syntax
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'tpope/vim-haml'
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}

" Git
Plug 'tpope/vim-fugitive'

call plug#end()
" }}}


" Settings
" {{{
set encoding=utf8
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set ignorecase               " Search case insensitive...
set clipboard^=unnamed       " Copy/paste using clipboard
set mouse=a                  " enable mouse
set foldmethod=marker

" Enable filetype plugins
filetype plugin on
filetype indent on

" Turn on the Wild menu
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set noshowmode " Hide the mode, since it's already shown by lightline

" Enable truecolor in iTerm
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:gruvbox_contrast_dark = 'soft'
set background=dark
colorscheme gruvbox


let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'gitbranch', 'filetype' ],
      \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos' ] ]
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \ },
      \ 'component': {
      \   'filename': '%F',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

let g:vimfiler_force_overwrite_statusline = 0
call vimfiler#custom#profile('default', 'context', {
    \ 'safe' : 0,
    \ })

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\   'sass': ['stylelint'],
\   'scss': ['stylelint'],
\   'ruby': ['solargraph', 'rubocop'],
\   'haml': ['hamllint']
\}

let g:ale_fixers = {
\       '*': ['trim_whitespace'],
\       'javascript': ['prettier'],
\       'vue': ['prettier'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '!' " Less aggressive than the default '>>'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_lint_on_text_changed = 0



" Tab completion
" will insert tab at beginning of line, and use completion if not at beginning
set wildmode=list:longest,list:full

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Indentation
" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent

"}}}

" UI
" {{{
syntax enable
set background=dark
set number                   " Show line numbers
set ruler
set listchars=tab:▷⋅,trail:·
set list

highlight Comment gui=italic
" Fix the disgusting visual selection colors of gruvbox (thanks @romainl).
hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#5a5a5a

" Set a custom highlight color when yanking text.
"   This requires having the plugin: machakann/vim-highlightedyank
hi HighlightedyankRegion cterm=NONE ctermbg=239 guibg=#4e4e4e
" }}}


" Key mapping
" {{{
let mapleader = ","

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"
nnoremap N Nzzzv
nnoremap n nzzzv

nnoremap U <C-R>|xnoremap U :<C-U>redo<CR>|

" Splits
nnoremap sv :vsplit<cr>
nnoremap sh :split<cr>

" Remove search highlight
nnoremap <cr> :nohlsearch<CR>

" Open vim config with <leader>ec (edit config)
if has('nvim')
  map <leader>ec :e ~/.config/nvim/init.vim<cr>
else
  map <leader>ec :e ~/.vimrc<cr>
endif

" Start RipGrep
nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>s :Rg <C-r><C-w>

" Show current file in vimfiler
nnoremap <Leader>f :VimFilerExplorer -find<cr>

" Bubbling lines
nmap <C-Up> ddlP
nmap <C-Down> ddp

nnoremap <c-p> :Files<cr>
map <leader>t :VimFilerExplorer<CR>
nnoremap <F3> :NumbersToggle<CR>

" Enable tab for auto completion
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Buffers
nnoremap <c-b> :Buffers<cr>
map <leader>bd :BD<cr>
map <leader>bn :BF<cr>
map <leader>bb :BB<cr>
map <leader>ba :BA<cr>
" A buffer becomes hidden when it is abandoned
set hidden

" Surround the visual selection in parenthesis/brackets/etc.
vnoremap $( <esc>`>a)<esc>`<i(<esc>
vnoremap $[ <esc>`>a]<esc>`<i[<esc>
vnoremap ${ <esc>`>a}<esc>`<i{<esc>
vnoremap $" <esc>`>a"<esc>`<i"<esc>
vnoremap $' <esc>`>a'<esc>`<i'<esc>

" Use :W to save after asking for password
command! W w !sudo tee "%" > /dev/null
" }}}


" Auto commands
" {{{
" Disable continuous comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}

" Plugins settings
" {{{
if executable('rg')
  let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!.git/*"'
endif

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" }}}
