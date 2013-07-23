"set laststatus=2                " Always show status line
set hlsearch			" Highlight searches
set ignorecase			" Ignore case on searching
set incsearch			" Incremental search
set smartcase                   " Ignores case if needle is all small 
                                " uses case otherwise
set nu                          " Show line numbers
syntax on			" Enable syntax highlighting
filetype indent plugin on	" Attempt to find filetype and allow
				" intelligent auto indenting

set hidden			" Hides buffers instead of closing them
set showcmd			" Show partial commands in last line

set autoindent			" When file is opened without type
set autoread                    " Autoread file if changed by outside program
set backspace=indent,eol,start	" Backspacing over autoindent
set showmatch                   " Show matching bracket
set ruler
set secure			" To avoid potential security
				" problems
set undolevels=1000
set wrapscan                    " Continue searching on top when hitting bottom
set tabstop=4

" Don't make swap files
set nobackup
set nowb
set noswapfile
set wildmenu

colorscheme elflord

" In visual selection mode pressing * or # searches for selected text
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Helper function
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

" Map ctrl+l/h for next or previous tabs
nmap <C-l> :tabn<CR>
nmap <C-h> :tabp<CR>

" Map F12 and Shift+F12 for buffer switching
:nmap <C-k> :bn<CR>
:nmap <C-k> :bp<CR>
" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>

" Turn on clang complete for c/cpp
filetype plugin on
let g:clang_user_options='|| exit 0'

" :Run bash will open a terminal
:command -nargs=1 Run ConqueTerm <args>

" Remap TaglistToggle command to TT
:command TT TlistToggle
set cul
hi CursorLine term=none cterm=none ctermbg=4
set autochdir
