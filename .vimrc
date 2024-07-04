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
set backupdir=$HOME/.vim/swaps
set dir=$HOME/.vim/swaps
set synmaxcol=220           " Because vim syntax highlighting sucks with long lines
set wildmode=list:longest,full " Perform completions in a more appropriate way"
set backspace=eol,indent,start " Backspace over everything
set omnifunc=syntaxcomplete#Complete " Enable omni completion"
set completeopt=menu,menuone,noselect
set autowrite   " Save file when :make is run

" Initialize plug
call plug#begin()
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
call plug#end()

" Enable language based stuff
syntax on
" filetype on
filetype plugin on
filetype plugin indent on

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bom
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Improve autocomplete menu color
hi Pmenu guibg=brown gui=bold

" Fix for markdown highlighting
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Ruby specific
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType eruby set tabstop=2 shiftwidth=2 softtabstop=2

" Javascript and HTML
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html set tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType vue set tabstop=2 shiftwidth=2 softtabstop=2

" Set colorscheme
colo jellybeans

" Because a \ sucks as a leader
let mapleader = ","

nmap <Leader>rr :source ~/.vimrc<CR>

" Map Control+l and h for buffer switching
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

" Navigate quick fixes efficiently
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>

" Launch nerdree
nnoremap <leader>n :NERDTreeFocus<CR>

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

" GVim specific options
if has("gui_running")
    set go-=m   " Hide menubar
    set go-=T   " Hide toolbar
    set go-=r   " Hide right scrollbar
    set go-=l   " Hide left scrollbar
    set go-=L   " Hide left scrollbar
    set go-=b   " Hide bottom scrollbar
    set go+=P   " Put visually selected text to clipboard
    set guifont=Monaco
    set mouse=c
    inoremap <c-space> <c-x><c-u>
endif

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

let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Setup fzf
let g:fzf_vim = {}
let g:fzf_vim.listproc = { list -> fzf#vim#listproc#quickfix(list) }
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()
