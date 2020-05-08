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

" Seamless navigation with tmux
Plug 'christoomey/vim-tmux-navigator'

" Vimfiler <leader>b
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/vimfiler.vim'

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Colors & UI
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'Yggdroot/indentLine'
" Plug 'myusuf3/numbers.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'qpkorr/vim-bufkill'
" Plug 'roman/golden-ratio'
Plug 'farmergreg/vim-lastplace' " reopen files at your last edit position
" Plug 'wellle/context.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-obsession'
Plug 'machakann/vim-highlightedyank'
Plug 'unblevable/quick-scope'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

Plug 'alok/notational-fzf-vim'
let g:nv_search_paths = ['~/wiki']

" Code utilities
Plug 'editorconfig/editorconfig-vim'
" insert mode auto-completion for quotes, parens, brackets
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
" Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'dense-analysis/ale'
Plug 'mattn/emmet-vim'
Plug 'dkarter/bullets.vim'

" highlights the XML/HTML tags that enclose your cursor location
Plug 'Valloric/MatchTagAlways', {'for': ['html', 'xml', 'xhtml', 'vue']}

" Languages & Syntax
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'elzr/vim-json'
Plug 'tpope/vim-haml'
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}
Plug 'wavded/vim-stylus', {'for': 'stylus'}
Plug 'ap/vim-css-color', {'for': ['css', 'scss', 'sass', 'stylus', 'vue', 'html']}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

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
set relativenumber

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
let g:gruvbox_contrast_dark = 'soft'
set background=dark
colorscheme palenight


let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
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

" let g:vimfiler_force_overwrite_statusline = 0
" let g:vimfiler_ignore_pattern = '^\%(\.git\|\.DS_Store\)$'
" call vimfiler#custom#profile('default', 'context', {
"     \ 'safe' : 0,
"     \ })

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
nnoremap <Leader>a :Rg<Space>
nnoremap <Leader>s :Rg <c-r><c-w>

" Show current file in vimfiler
nnoremap <Leader>f :VimFilerExplorer -find<cr>
nnoremap <Leader>f :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

" Bubbling lines
nmap <c-Up> :m .-2<cr>
nmap <c-Down> :m .+1<cr>

" ALE moving between errors
nmap <silent> <c-k> <Plug>(ale_previous_wrap)
nmap <silent> <c-j> <Plug>(ale_next_wrap)

nnoremap <c-p> :Files<cr>
" map <leader>t :VimFilerExplorer<CR>
map <leader>t :Defx -toggle -split=vertical -direction=topleft -winwidth=50<CR>
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

" Enable tab for auto completion
inoremap <expr> <Tab> pumvisible() ? "\<c-n>" : "\<Tab>"

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
  let $FZF_DEFAULT_COMMAND= 'rg --files --hidden -g "!.git/*"'
endif

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
let g:deoplete#enable_at_startup = 1

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
" }}}

