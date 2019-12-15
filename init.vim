if v:progname == 'vi'
  set noloadplugins " if vi is being used, don't use plugins
endif

call plug#begin('~/.local/share/nvim/plugged')

" Utilities
Plug 'tpope/vim-dispatch'

" Text manipulation
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth' " detect indentation of the openned file
Plug 'dense-analysis/ale'
Plug 'wellle/context.vim'

Plug 'dyng/ctrlsf.vim' " code search and view tool, and lets you edit file in-place

Plug 'editorconfig/editorconfig-vim'

" Colorschemes
" Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dustinknopoff/TeaCode-Vim-Extension'

Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'gregsexton/MatchTag'


" Languages
" Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'tpope/vim-rails'
Plug 'posva/vim-vue'
Plug 'tpope/vim-haml'
Plug 'vim-ruby/vim-ruby'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mxw/vim-jsx',
" Plug 'neoclide/vim-jsx-improve'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'StanAngeloff/php.vim', {'for' : 'php'}
" Plug 'jwalton512/vim-blade', {'for': 'php'}

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" UI
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-buftabline'
Plug 'myusuf3/numbers.vim'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'

" Uncategorized
Plug 'rizzatti/dash.vim'
" Plug 'ervandew/supertab'
" Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'alvan/vim-closetag' " auto close html tags
Plug 'Valloric/MatchTagAlways'
" Plug 'wakatime/vim-wakatime'
" Plug 'ludovicchabant/vim-gutentags'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

call plug#end()


" =======================
" Config
" =======================

" General
" ------------------
set encoding=utf8
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set ignorecase               " Search case insensitive...
set nocursorcolumn           " speed up syntax highlighting
set noshowmode               " Hide current mode, it's already shown inside airline/lightline

set hidden

" Copy/paste using clipboard
set clipboard^=unnamed
set clipboard^=unnamedplus

set mouse=a 		     " enable mouse

set backspace=indent,eol,start " fix backspace in insert mode

" UI
" ------------------



if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
endif
if (has("termguicolors"))
  set termguicolors
endif


syntax enable
set background=light
" let ayucolor="light" " for mirage version of theme

" let g:PaperColor_Theme_Options = {
  " \   'theme': {
  " \     'default': {
  " \       'transparent_background': 1,
  " \       'allow_italic': 1
  " \     }
  " \   }
  " \ }

" colorscheme ayu  "onedark ayu Tomorrow-Night onedark nova OceanicNext
" colorscheme solarized8
colorscheme nord
" highlight Normal ctermfg=grey ctermbg=black
" highlight Comment cterm=italic
" highlight htmlArg cterm=italic
set number                   " Show line numbers

set listchars=tab:▷⋅,trail:·
set list
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1


" if exists('+colorcolumn')
  " Highlight up to 280 columns (this is the current Vim max) beyond 'textwidth'
  " let &l:colorcolumn='80,+' . join(range(0, 279), ',+')
" endif



" Plugins config
" ------------------

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['gitbranch'], [ 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
    \ }

if executable('rg')
  let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!.git/*"'
endif

nnoremap <c-p> :Files<cr>
nnoremap <F3> :NumbersToggle<CR>


inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"


" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let g:dispatch_handlers = ['job']

" Key mapping
" -----------------

let mapleader = ","

nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>


" Exit insert mode on nn
imap nn <Esc>
imap <C-e> <C-o>:call TeaCodeExpand()<CR>

" map <leader>b :NERDTreeToggle<CR>
map <leader>b :VimFilerExplorer<CR>
map [b :bp<cr>
map ]b :bn<cr>
map <leader>q :bw<cr>

map <leader>e :Buffers<cr>

if has('nvim')
  map <leader>ec :e ~/.config/nvim/init.vim<cr>
else
  map <leader>ec :e ~/.vimrc<cr>
endif

nmap <cr> :noh<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'


" Auto source (n)vimrc
autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

" Disable continuous comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Settings for ALE to use stylelint and eslint in JSX
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

let g:ale_linters = {
\	'js': ['prettier'],
\	'ts': ['tslint'],
\	'tsx': ['tslint'],
\	'jsx': ['standard'],
\	'sass': ['sasslint'],
\	'scss': ['sasslint'],
\	'php': ['php'],
\       'ruby': ['solargraph', 'rubocop'],
\       'haml': ['hamllint']
\}

let g:ale_fixers = {
\       'js': ['prettier'],
\       'jsx': ['prettier'],
\       'ts': ['prettier'],
\       'tsx': ['prettier']
\}

let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_completion_enabled = 1

let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '!' " Less aggressive than the default '>>'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_lint_on_text_changed = 0


let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"

let g:OmniSharp_selector_ui = 'ctrlp'

" let g:jsx_ext_required = 0

" Where to store tag files
let g:gutentags_cache_dir = '~/.vim/gutentags'
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']

let g:php_namespace_sort_after_insert=1

let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']

" LimeLight config
"
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1



" Fix multiple cursors with deoplete
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists('g:deoplete#disable_auto_complete') 
    let g:deoplete#disable_auto_complete = 1
  endif
endfunction

set conceallevel=0
let g:vim_json_syntax_conceal = 0

nnoremap <leader>% :MtaJumpToOtherTag<cr>
let g:mta_filetypes = {
            \ 'html' : 1, 'xhtml' : 1, 'xml' : 1,
            \ 'javascript' : 1,
            \ 'javascript.jsx' : 1,
            \ 'javascript.tsx' : 1,
            \ 'typescript.tsx' : 1,
            \ 'typescript' : 1
            \}

" Bubbling lines
nmap <C-Up> ddkP
nmap <C-Down> ddp


" Keep things at a specific line length
highlight OverLength ctermbg=161 ctermfg=white guibg=#FFD9D9
" augroup overlength
  " autocmd!
  " autocmd FileType c,cpp,markdown,gitcommit,ruby,python,lisp
        " \ match OverLength /\%>80v.\+/
  " autocmd FileType javascript,typescript match OverLength /\%>80v.\+/
  " autocmd FileType java match OverLength /\%>120v.\+/
" augroup END



" coc settings
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


let g:vimfiler_as_default_explorer = 1

" IndentLine {{
let g:indentLine_enabled = 1
" let g:indentLine_char = ''
" let g:indentLine_first_char = ''
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
" let g:indentLine_color_term = 255
" let g:indentLine_color_gui = '#dddddd'
" }}


" Italic fonts
highlight Comment gui=italic
highlight htmlArg gui=italic
highlight javascriptImport gui=italic
highlight javascriptExport gui=italic
highlight javascriptFuncKeyword gui=italic
highlight javascriptVariable gui=italic
highlight javascriptIdentifier gui=italic

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Prettier config
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full

" Always use vertical diffs
set diffopt+=vertical


