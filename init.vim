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

let g:coc_global_extensions = [
			\ 'coc-tabnine',
			\ 'coc-stylelintplus',
			\ 'coc-eslint',
			\ 'coc-prettier',
			\ 'coc-css',
			\ 'coc-cssmodules',
			\ 'coc-yaml',
			\ 'coc-tsserver',
			\ 'coc-vetur',
			\ 'coc-html',
			\ 'coc-emmet',
			\ 'coc-markdownlint',
			\ 'coc-json',
			\ 'coc-snippets'
			\ ]

let g:vimade = { "fadelevel": 0.7 }


call plug#begin('~/.local/share/nvim/plugged')

" Utilities
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'dyng/ctrlsf.vim'
Plug 'junegunn/vim-easy-align'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Manipulate words (change case with crs/cru/cr-)
Plug 'tpope/vim-abolish'
Plug 'AndrewRadev/tagalong.vim' " Change closing tag automatically
Plug 'terryma/vim-multiple-cursors'

" Seamless navigation with tmux
Plug 'christoomey/vim-tmux-navigator'


if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Colors & UI
Plug 'arcticicestudio/nord-vim'
" Plug 'gruvbox-community/gruvbox'
" Plug 'adrian5/oceanic-next-vim'
" Plug 'NieTiger/halcyon-neovim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'Yggdroot/indentLine'
" Plug 'myusuf3/numbers.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'qpkorr/vim-bufkill'
" Plug 'roman/golden-ratio'
Plug 'farmergreg/vim-lastplace' " reopen files at your last edit position
" Plug 'wellle/context.vim'
Plug 'mhinz/vim-signify'
" Plug 'tpope/vim-obsession'
Plug 'machakann/vim-highlightedyank'
Plug 'unblevable/quick-scope'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'jmckiern/vim-venter'
Plug 'liuchengxu/vim-which-key'
" Plug 'TaDaa/vimade'



let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Code utilities
" Plug 'editorconfig/editorconfig-vim'
" insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth' " set indentation
Plug 'tpope/vim-markdown'
" Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim', {'for': ['html', 'vue']}
Plug 'dkarter/bullets.vim'
Plug 'mbbill/undotree'
" Plug 'itchyny/vim-cursorword'
Plug 'ruanyl/vim-gh-line'
Plug 'wsdjeg/vim-fetch' " jump to specified line/column when opening a file
Plug 'vim-test/vim-test'
Plug 'jebaum/vim-tmuxify'

" highlights the XML/HTML tags that enclose your cursor location
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml', 'xhtml', 'vue']}

" Languages & Syntax
let g:polyglot_disabled = []
" Plug 'sheerun/vim-polyglot'

Plug 'posva/vim-vue'
let g:vue_pre_processors = 'detect_on_enter'

Plug 'kevinoid/vim-jsonc'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'jparise/vim-graphql'

" Git
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'rhysd/committia.vim'

Plug 'phaazon/hop.nvim'


call plug#end()
" }}}


" Settings
" {{{
set encoding=utf8
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set undodir=~/.config/nvim/undodir
set undofile
set nowrap
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set ignorecase               " Search case insensitive...
set clipboard^=unnamed       " Copy/paste using clipboard
set foldenable
set foldlevel=99
set foldmethod=marker
set foldmarker={{{,}}}
set relativenumber
set cursorline              " Highlight current line
set mouse=a
set showtabline=2

" Enable filetype plugins
filetype plugin on
filetype indent on

" Turn on the Wild menu
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set noshowmode " Hide the mode, since it's already shown by lightline
set noemoji

" Enable truecolor in iTerm
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors " this is used to fix Limelight plugin
let g:gruvbox_contrast_dark = 'medium'
let g:oceanic_italic_comments = 1
let g:oceanic_for_polyglot = 1

set background=dark
colorscheme palenight
let g:nord_italic = 1



let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'gitbranch', 'filetype' ],
      \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos' ] ]
      \ },
  \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'buffers': 'tabsel',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status',
      \ },
      \ 'component': {
      \   'filename': '%F',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }

" let g:vimfiler_force_overwrite_statusline = 0
" let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
" call vimfiler#custom#profile('default', 'context', {
"     \ 'safe' : 0,
"     \ })

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#enable_nerdfont = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vue': ['eslint'],
\   'css': ['stylelint'],
\   'sass': ['stylelint'],
\   'scss': ['stylelint'],
\   'ruby': ['solargraph', 'rubocop'],
\   'haml': ['haml-lint']
\}

let g:ale_fixers = {
\       '*': ['trim_whitespace'],
\       'javascript': ['prettier'],
\       'vue': ['prettier'],
\}


let g:ale_disable_lsp = 1 " Disable ALE LSP in favor of CoC.vim
let g:ale_fix_on_save = 1
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '!' " Less aggressive than the default '>>'
let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
let g:ale_lint_on_text_changed = 0

let g:markdown_fenced_languages = ['html', 'javascript', 'vue', 'ruby', 'bash=sh']


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
set autoindent "Auto indent
set smartindent "Smart indent

" Change cursor shape for iTerm2 on macOS {
  " bar in Insert mode
  " inside iTerm2
  if $TERM_PROGRAM =~# 'iTerm'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  " inside tmux
  if exists('$TMUX') && $TERM != 'xterm-kitty'
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif

  " inside neovim
  if has('nvim')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
  endif
" }

"}}}

" UI
" {{{
syntax enable
set background=dark
set number                   " Show line numbers
set ruler
set listchars=tab:▷⋅,trail:·,extends:↷,precedes:↶
set list


highlight Comment gui=italic
highlight Keyword gui=italic
highlight Function gui=italic
highlight htmlArg gui=italic
" Fix the disgusting visual selection colors of gruvbox (thanks @romainl).
" hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#5a5a5a

" Set a custom highlight color when yanking text.
"   This requires having the plugin: machakann/vim-highlightedyank
hi HighlightedyankRegion cterm=NONE ctermbg=239 guibg=#4e4e4e
highlight clear SignColumn  " SignColumn should match background
" }}}


" Key mapping
" {{{
let mapleader = ","

" jj | escaping
inoremap jj <Esc>
cnoremap jj <C-c>

" Yank to the end of line
nnoremap Y y$
" Fold {
nnoremap <silent> <Leader>f0 :set foldlevel=0<CR>
nnoremap <silent> <Leader>f1 :set foldlevel=1<CR>
nnoremap <silent> <Leader>f2 :set foldlevel=2<CR>
nnoremap <silent> <Leader>f3 :set foldlevel=3<CR>
nnoremap <silent> <Leader>f4 :set foldlevel=4<CR>
nnoremap <silent> <Leader>f5 :set foldlevel=5<CR>
nnoremap <silent> <Leader>f6 :set foldlevel=6<CR>
nnoremap <silent> <Leader>f7 :set foldlevel=7<CR>
nnoremap <silent> <Leader>f8 :set foldlevel=8<CR>
nnoremap <silent> <Leader>f9 :set foldlevel=9<CR>
nnoremap <silent> <Leader>fa zA<CR> " toggle fold
" }
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"
nnoremap N Nzzzv
nnoremap n nzzzv

nnoremap U <c-R>|xnoremap U :<c-U>redo<CR>|

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
nnoremap <Leader>s :Rg<Space>
nnoremap <Leader>sw :Rg <c-r><c-w>

" Show current file in file explorer (defx)
nnoremap <Leader>sf :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

" yank file path/name
nnoremap <Leader>yf :let @*=expand("%")<CR>       " Mnemonic: yank file relative path
nnoremap <Leader>yff :let @*=expand("%:p")<CR>    " Mnemonic: Yank file full path

" Bubbling lines
nmap <c-Up> :m .-2<cr>
nmap <c-Down> :m .+1<cr>

" ALE moving between errors
nmap <silent> <c-k> <Plug>(ale_previous_wrap)
nmap <silent> <c-j> <Plug>(ale_next_wrap)

" Fugitive Git shortcuts
nmap <leader>ga :Git add<cr>
nmap <leader>gb :Git blame<cr>
nmap <leader>gc :Git commit<cr>
nmap <leader>gp :Git push<cr>
nmap <leader>gs :Git status<cr>

" vim-test shortcuts

nmap <silent> <leader>tt :TestNearest<CR> " Mnemonic: test nearest (double t is faster)
nmap <silent> <leader>tf :TestFile<CR>    " Mnemonic: test file
nmap <silent> <leader>ts :TestSuite<CR>   " Mnemonic: test suite
nmap <silent> <leader>tl :TestLast<CR>    " Mnemonic: test last
nmap <silent> <leader>tv :TestVisit<CR>   " Mnemonic: test visit

nnoremap <c-p> :Files<cr>
map <leader>t :Defx -columns=icons:indent:filename:type -toggle -split=vertical -direction=topleft -winwidth=50<CR>
nnoremap <F3> :NumbersToggle<CR>
let g:numbers_exclude = ['goyo_pad']

" Goyo and Limelight config
autocmd BufLeave goyo_pad setlocal norelativenumber
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('open', 'pedit')
	  nnoremap <silent><buffer><expr> t
	  \ defx#do_action('open_or_close_tree')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> <bs>
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction
<

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

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

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying codeAction to the current line.
nmap <leader>ca  <Plug>(coc-codeaction)

nnoremap <silent> <leader>p  :<C-u>CocList commands<cr>

" Buffers
nnoremap <c-b> :Buffers<cr>
map <leader>bd :BD<cr>
map <leader>bn :BF<cr>
map <leader>bb :BB<cr>
map <leader>b, :BA<cr>
" delete all buffers
map <leader>ba :bufdo BD<cr>
" <Leader>b[1-9] move to buffer [1-9] source: https://github.com/liuchengxu/dotfiles/blob/b20342f6ad133f44ad1006865cf0e970c4c13625/vimrc#L88
for s:i in range(1, 9)
  execute 'nnoremap <Leader>b' . s:i . ' :b' . s:i . '<CR>'
endfor

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

let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0

let g:gh_line_map = '<leader>rl' " remote link
let g:gh_line_blame_map = '<leader>rb' " remote blame

nmap <leader>a <Plug>(EasyAlign)
xmap <leader>a <Plug>(EasyAlign)

" }}}


" Auto commands
" {{{
" source: https://stackoverflow.com/a/6052704
function! RestoreSess()
if filereadable(getcwd() . '/Session.vim')
    execute 'so ' . getcwd() . '/Session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

" autocmd VimEnter * nested call RestoreSess()
" Disable continuous comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" }}}


" Plugins settings
" {{{
if executable('rg')
  let $FZF_DEFAULT_COMMAND= 'rg --files --follow --hidden -g "!.git/*"'
endif
let $FZF_DEFAULT_OPTS='--reverse'
let $BAT_THEME="base16"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()

" Always show quotes in json
let g:vim_json_syntax_conceal = 0
let g:indentLine_concealcursor=""


" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" Trigger a unblevable/quick-scope plugin highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Highlight vue attribute value as expression instead of string.
let g:vim_vue_plugin_highlight_vue_attr = 1

let g:vue_pre_processors = ['scss']

" set to 1, the vim will refresh markdown when save the buffer or leave from insert mode
let g:mkdp_refresh_slow = 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 1,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }

let g:mkdp_markdown_css = expand('~/.dotfiles/markdown.css')
let g:cursorword_delay = 1500

let g:Hexokinase_highlighters = ['sign_column'] " possible interesting value: 'backgroundfull'

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

" Settings for vim-which-key
" {{{
set timeoutlen=500

call which_key#register(',', "g:which_key_map")

let g:which_key_map = {}
let g:which_key_map['a'] = {
      \ 'name' : '+align' ,
      \ }
let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ }
let g:which_key_map['f'] = {
      \ 'name' : '+fold',
      \ '0': 'set foldlevel to 0',
      \ '1': 'set foldlevel to 1',
      \ '2': 'set foldlevel to 2',
      \ '3': 'set foldlevel to 3',
      \ '4': 'set foldlevel to 4',
      \ '5': 'set foldlevel to 5',
      \ '6': 'set foldlevel to 6',
      \ '7': 'set foldlevel to 7',
      \ '8': 'set foldlevel to 8',
      \ '9': 'set foldlevel to 9',
      \ 'a': 'toggle fold'
      \ }
let g:which_key_map['s'] = {
      \ 'name': '+show'
      \ }
let g:which_key_map['y'] = {
      \ 'name' : '+yank',
      \ 'p'    : ['yp', 'relative path'],
      \ 'f'    : ['yfp', 'full path']
      \ }
let g:which_key_map['r'] = {
      \ 'name' : '+remote',
      \ 'l'    : 'remote file link',
      \ 'b'    : 'remote file blame link',
      \}

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual ','<CR>
" }}}
" }}}

" Highlight the search with different colors than the cursor - seems a palenight issue
hi Search guibg=peru  guifg=wheat cterm=NONE ctermfg=grey ctermbg=blue

" Hop config
lua require'hop'.setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
lua vim.api.nvim_set_keymap('n', '<c-j>', "<cmd>lua require'hop'.hint_words()<cr>", {})

" vim-test config
let g:test#javascript#runner = 'jest'
let g:tmuxify_custom_command = 'tmux split-window -h'
let test#strategy = "neovim"

