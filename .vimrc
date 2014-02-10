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
set laststatus=0            " Always show the status line at the bottom
set wrapscan                " Wrap searches from top if hit bottom
set tabstop=4               " Tab is 4 spaces
set cul                     " Highlight cursor line
set shiftround              " Set indentation in multiples of shiftwidth
"set foldmethod=indent       " Folding based on indentation
set expandtab               " Use spaces in place of tabs
set hidden                  " Allow switching buffers without saving
set shiftwidth=4

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

" Ruby specific
" autocmd FileType ruby set makeprg brazil-build\ apollo-pk" g

" Set colorscheme
colo Tomorrow-Night-Eighties

" Because a \ sucks as a leader
let mapleader = ","

" Map F12 and Shift+F12 for buffer switching
nnoremap <silent> <F12> :bn<CR>
nnoremap <silent> <S-F12> :bp<CR>

" Map Control+l and h for tab switching
nmap <C-l> :tabn<CR>
nmap <C-h> :tabp<CR>

" Press enter to remove search highlights
nmap <silent> <CR> :nohlsearch<CR>

" :Run bash will open a terminal
command -nargs=1 Run ConqueTerm <args>

" Remap plugin launch commands
nmap <Leader>nt :NERDTree<CR>
nmap <Leader>fb :FufBuffer<CR>
nmap <Leader>ff :FufFile<CR>
nmap <Leader>ft :FufTag<CR>
nmap <Leader>rr :source ~/.vimrc<CR>
nmap <Leader>mbe :MBEToggle<CR>

let Tlist_Use_Right_Window = 1

" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

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
