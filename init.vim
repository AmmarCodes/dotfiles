if v:progname == 'vi'
  set noloadplugins
endif

call plug#begin('~/.local/share/nvim/plugged')

" JS plugins
Plug 'othree/yajs.vim'
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'neoclide/vim-jsx-improve'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'Yggdroot/indentLine'

" Colorschemes
Plug 'mhartington/oceanic-next'
" Plug 'morhetz/gruvbox'
" Plug 'trevordmiller/nova-vim'
" Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
" Plug 'logico-dev/typewriter'
Plug 'ayu-theme/ayu-vim'
Plug 'yarisgutierrez/ayu-lightline'
" Plug 'chriskempson/vim-tomorrow-theme'

" Code
Plug 'editorconfig/editorconfig-vim'
" Plug 'ctrlpvim/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
" Plug 'mattn/emmet-vim'
Plug 'tpope/vim-sleuth' " detect indentation of the openned file
Plug 'w0rp/ale' " Plug 'vim-syntastic/syntastic'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'raimondi/delimitmate'
" Plug 'junegunn/vim-easy-align'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'luochen1990/rainbow'
Plug 'vim-ruby/vim-ruby'


" Languages
" Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'othree/html5.vim'
Plug 'gregsexton/MatchTag'
Plug 'tpope/vim-haml'
Plug 'hail2u/vim-css3-syntax'
Plug 'StanAngeloff/php.vim', {'for' : 'php'}
" Plug 'shawncplus/phpcomplete.vim'
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug '2072/vim-syntax-for-PHP', {'for': 'php'}
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
" Plug 'phpstan/vim-phpstan', {'for': 'php'}
Plug 'jwalton512/vim-blade', {'for': 'php'}
Plug 'gabrielelana/vim-markdown', {'for': 'markdown'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}
" Plug 'OmniSharp/omnisharp-vim'
Plug 'tpope/vim-dispatch'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx', 

" UI
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'

Plug 'airblade/vim-gitgutter'
" Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-buftabline'
Plug 'myusuf3/numbers.vim'
" Plug 'liuchengxu/vim-which-key' ", { 'on': ['WhichKey', 'WhichKey!'] }


" Uncategorized
" Plug 'ervandew/supertab'
" Plug 'valloric/youcompleteme'
Plug 'SirVer/ultisnips'
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

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'



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
  if (has("termguicolors"))
    set termguicolors
  endif
endif


syntax enable
set background=light
let ayucolor="light" " for mirage version of theme
colorscheme ayu  "onedark ayu Tomorrow-Night onedark nova OceanicNext
" highlight Normal ctermfg=grey ctermbg=black
" highlight Comment cterm=italic
" highlight htmlArg cterm=italic
set number                   " Show line numbers

set listchars=tab:▷⋅,trail:·
set list



" Plugins config
" ------------------

" let g:airline_theme='oceanicnext'
" let g:airline_powerline_fonts = 1

" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1

let g:lightline = {
      \ 'colorscheme': 'PaperColor',
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
  let $FZF_DEFAULT_COMMAND= 'rg --files'
endif

nnoremap <c-p> :Files<cr>
nnoremap <F3> :NumbersToggle<CR>



" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_max_files=0
" let g:ctrlp_max_depth=40
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" let g:ctrlp_custom_ignore = 'vendor\|node_modules\|git'
" let g:ctrlp_match_window_bottom = 0
" let g:ctrlp_match_window_reversed = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" Key mapping
" -----------------

let mapleader = ","

nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>


" Exit insert mode on jk
imap jf <Esc>

" map <leader>b :NERDTreeToggle<CR>
map <leader>b :VimFilerExplorer<CR>
map [b :bp<cr>
map ]b :bn<cr>
map <leader>q :bw<cr>

map <leader>e :CtrlPBuffer<cr>

if has('nvim')
  map <leader>ec :e ~/.config/nvim/init.vim<cr>
else
  map <leader>ec :e ~/.vimrc<cr>
endif

map <cr> :noh<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> <leader> :WhichKey ','<CR>
set timeoutlen=500
let g:which_key_map =  {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }


let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Change indent guide color
let g:indentLine_color_gui = '#4c4c4b'

" Config for PHPUse
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" Auto source nvimrc
autocmd BufWritePost init.vim source %


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
\	'php': ['php']
\}

" let g:ale_javascript_standard_executable = 'semistandard'
" let g:ale_javascript_standard_use_global = 1

""\	'php': ['phpcbf'],
let g:ale_fixers = {
\       'js': ['prettier'],
\       'jsx': ['prettier'],
\       'ts': ['prettier'],
\       'tsx': ['prettier']
\}

let g:ale_linter_aliases = {'jsx': 'css'}
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 1

let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '!' " Less aggressive than the default '>>'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_lint_on_text_changed = 0


let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php"

let g:OmniSharp_selector_ui = 'ctrlp'

let g:jsx_ext_required = 0

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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


" Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

let g:vimfiler_as_default_explorer = 1

" Show trailing whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" IndentLine {{
" let g:indentLine_char = ''
" let g:indentLine_first_char = ''
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0
let g:indentLine_color_term = 255
let g:indentLine_color_gui = '#dddddd'
" }}


" Italic fonts
highlight Comment gui=italic
highlight htmlArg gui=italic
highlight javascriptImport gui=italic
highlight javascriptExport gui=italic
highlight javascriptFuncKeyword gui=italic
highlight javascriptVariable gui=italic
highlight javascriptIdentifier gui=italic

