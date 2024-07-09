set nocompatible            " Disable vi compatibility mode
set t_Co=256                " 256 colors terminal
set nu                      " Show line numbes
set hlsearch                " Set highlighting of searches
set ignorecase              " Case in-sensitive search
set smartcase               " Case sensitive search if any letter is caps
set incsearch               " Incremental search
set autoread                " Automatically reload file if changed by external program
set showmatch               " Show matching brackets
set undolevels=1000         " 1000 levels of undoing
set laststatus=2            " Always show the status line at the bottom
set wrapscan                " Wrap searches from top if hit bottom
set tabstop=4               " Tab is 4 spaces
set shiftround              " Set indentation in multiples of shiftwidth
set expandtab               " Use spaces in place of tabs
set hidden                  " Allow switching buffers without saving
set shiftwidth=4            " Indentation will use 4 spaces
set tabstop=4
set softtabstop=4
set autoindent
set synmaxcol=220           " Because vim syntax highlighting sucks with long lines
set wildmode=list:longest,full " Perform completions in a more appropriate way"
set backspace=eol,indent,start " Backspace over everything
set omnifunc=syntaxcomplete#Complete " Enable omni completion
set completeopt=menu,menuone,noselect
set autowrite   " Save file when :make is run
if has("win32")
    set backupdir=$HOME/vimfiles/swaps
    set dir=$HOME/vimfiles/swaps
else
    set backupdir=$HOME/.vim/swaps
    set dir=$HOME/.vim/swaps
endif
if has("gui")
    set go-=m   " Hide menubar
    set go-=T   " Hide toolbar
    set go-=r   " Hide right scrollbar
    set go-=l   " Hide left scrollbar
    set go-=L   " Hide left scrollbar
    set go-=b   " Hide bottom scrollbar
    set go+=P   " Put visually selected text to clipboard
    set mouse=c
    inoremap <c-space> <c-x><c-u>
    set guifont=Monaco
endif
if has("gui_win32")
  set guifont=Consolas:h11:cANSI
endif

" Initialize plug
call plug#begin()
Plug 'tpope/vim-obsession'
if has("win32")
    Plug 'ctrlpvim/ctrlp.vim'
else
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
endif
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'OmniSharp/omnisharp-vim'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'moll/vim-node'
Plug 'isRuslan/vim-es6'
Plug 'posva/vim-vue'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nickspoons/vim-sharpenup'
Plug 'puremourning/vimspector'
call plug#end()

" Enable language based stuff
syntax on
filetype plugin on
filetype plugin indent on

let mapleader = ","
if has("win32")
    nmap <Leader>rr :source $HOME/vimfiles/vimrc<CR>
else
    nmap <Leader>rr :source $HOME/.vimrc<CR>
endif

" Set colorscheme
colo slate

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Fix for markdown highlighting
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Improve autocomplete menu color
hi Pmenu guibg=brown gui=bold

" Ruby specific
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType eruby set tabstop=2 shiftwidth=2 softtabstop=2

" Javascript and HTML
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vue set tabstop=2 shiftwidth=2 softtabstop=2

" Because a \ sucks as a leader
" Map Control+l and h for buffer switching
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

" Navigate quick fixes efficiently
if !has("win32")
    map <C-n> :cnext<CR>
    map <C-p> :cprevious<CR>
endif
nnoremap <leader>a :cclose<CR>

" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>


" Search for selected text using * and #
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Helper function for visual selection
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_y = 'Obsession: %{ObsessionStatus("ON", "OFF")}'

" Matching rules
match ErrorMsg /\%>120v.\+/  "Don't like any lines greater than 120 chars
match ErrorMsg /\s+$/   " Don't like whitespaces at end of line

" Alt-up/down should behave in a WYSWIG manner(for looong lines)
map <A-DOWN> gj
map <A-UP> gk
imap <A-UP> <ESC>gki
imap <A-DOWN> <ESC>gji

" Golang specific configuration
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>i <Plug>(go-info)

if executable('gopls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })
endif

" C# Specific
let s:using_snippets = 1
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_want_snippet=1
let g:UltiSnipsExpandTrigger="<tab>"
let g:OmniSharp_server_stdio = 1
if has("win32")
    let g:OmniSharp_selector_ui = 'ctrlp'
    let g:OmniSharp_selector_findusages = 'ctrlp'
else
    let g:OmniSharp_selector_ui = 'fzf'
    let g:OmniSharp_selector_findusages = 'fzf'
endif
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0],
  \ 'border': [1],
  \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
  \ 'borderhighlight': ['ModeMsg']
  \}
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Setup ALE
let g:ale_linters = { 'cs': ['OmniSharp'], 'go': ['gopls'] }
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1

" Setup autocompletion
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_auto_popup = 1
set completeopt=menuone,noinsert,preview
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Setup NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['obj$', 'bin$', 'Properties$', '__blobstorage__$']

let g:vimspector_enable_mappings = 'HUMAN'

" Setup fzf on Linux and ctrl-p on windows
if !has("win32")
    let g:fzf_vim = {}
    let g:fzf_vim.listproc = { list -> fzf#vim#listproc#quickfix(list) }
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>fg :GFiles<CR>
    nnoremap <leader>fb :Buffers<CR>
    nnoremap <leader>fh :History<CR>
else
    " Ignore files in .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|obj|out)$',
    \ 'file': '\v\.(exe|so|dll|obj)$',
    \ }
    " Customize ctrlp
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_working_path_mode = 'ra'
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.dll,*.obj  " Windows
endif
