" Amazon specific vimrc
"source /apollo/env/envImprovement/var/vimrc

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

" Initialize vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Load plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/L9'
Plugin 'tpope/vim-obsession'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-syntastic/syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-endwise'
Plugin 'moll/vim-node'
Plugin 'isRuslan/vim-es6'
Plugin 'posva/vim-vue'
Plugin 'tpope/vim-rails'
call vundle#end()

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
  "setglobal bomb
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

" Map F12 and Shift+F12 for buffer switching
nnoremap <silent> <F12> :tabn<CR>
nnoremap <silent> <S-F12> :tabp<CR>

" Map Control+l and h for tab switching
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>

" :Run bash will open a terminal
command -nargs=1 Run ConqueTerm <args>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_y = 'Obsession: %{ObsessionStatus("ON", "OFF")}'

nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>ff :FufFile<CR>
nmap <Leader>ft :FufTag<CR>
nmap <Leader>rr :source ~/.vimrc<CR>

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
match ErrorMsg /\%>80v.\+/  "Don't like any lines greater than 80 chars 
match ErrorMsg /\s+$/   " Don't like whitespaces at end of line

noremap <c-s> :update<CR><CR>
vnoremap <c-s> <c-c>:update<CR><CR>
inoremap <c-s> <c-c>:update<CR><CR>

" Alt-up/down should behave in a WYSWIG manner(for looong lines)
map <A-DOWN> gj
map <A-UP> gk
imap <A-UP> <ESC>gki
imap <A-DOWN> <ESC>gji
