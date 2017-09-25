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
set cul                     " Highlight cursor line
set shiftround              " Set indentation in multiples of shiftwidth
set expandtab               " Use spaces in place of tabs
set hidden                  " Allow switching buffers without saving
set shiftwidth=2            " Indentation will use 2 spaces by default
set tabstop=2               " Tab is 2 spaces by default
set ttimeoutlen=50
set cc=120                  " Reminder for longer lines of code
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swap
set updatetime=250          " Set the update time to a quarter of second

" Perform completions in a more appropriate way
set wildmode=list:longest,full

" Backspace over everything
set backspace=eol,indent,start

" Improve cursor line colors
hi CursorLine term=none cterm=none ctermbg=4

" Improve autocomplete menu color
hi Pmenu guibg=brown gui=bold

" Enable omni completion
set omnifunc=syntaxcomplete#Complete

" Enable language based stuff
syntax on
filetype on
filetype plugin on
filetype indent plugin on

" Pathogenic infection
execute pathogen#infect()

" Set colorscheme
colo jellybeans

" Because a \ sucks as a leader
let mapleader = ","

" Map F12 and Shift+F12 for tab switching
nnoremap <silent> <F12> :tabn<CR>
nnoremap <silent> <S-F12> :tabp<CR>

" Map Control+l and h for buffer switching
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>

" Leading shortcuts
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>ff :FufFile<CR>
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
    cd Documents/Projects
endif

" Matching rules
match ErrorMsg /\%>80v.\+/  "Don't like any lines greater than 80 chars 
match ErrorMsg /\s+$/   " Don't like whitespaces at end of line

autocmd BufRead,BufNewFile *.md set filetype=markdown
noremap <c-s> :update<CR><CR>
vnoremap <c-s> <c-c>:update<CR><CR>
inoremap <c-s> <c-c>:update<CR><CR>
map <A-DOWN> gj
map <A-UP> gk
imap <A-UP> <ESC>gki
imap <A-DOWN> <ESC>gji

"" Plugin configurations
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme = 'powerlineish'
let g:airline_enable_branch = 1
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
" Snipmate
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal cul!
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
