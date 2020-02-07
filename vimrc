set nocompatible

syntax enable
filetype plugin indent on

" Disable backups.
set nobackup
set nowritebackup
set noswapfile

" Default file encoding.
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix
set fileformats=unix,dos

" Enable fuzzy finding of files and buffers.
set path+=**
set wildmenu

" Configure indentation.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set copyindent
set shiftround
set expandtab
set smarttab
" Don't remove indentation on Python comments.
inoremap # X<BS>#
" Smaller indentation in javascript and HTML files.
autocmd FileType html setlocal sw=2 ts=2
autocmd FileType javascript setlocal sw=2 ts=2

set backspace=indent,eol,start

" Display leading spaces as dots.
set conceallevel=2
set concealcursor=nvi
autocmd BufWinEnter,BufReadPre * syntax match LeadingSpace /\(^ *\)\@<= / containedin=ALL conceal cchar=·
highlight Conceal ctermfg=14 guifg=#586E75

" Configure searching.
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan

" Configure folding.
set foldmethod=indent
set foldlevel=99

" Remap the keys for navigating splits.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Configure the user interface.
set colorcolumn=80
set nowrap
set number
set relativenumber
set numberwidth=7
set laststatus=2
set splitbelow
set splitright
set vb
set t_vb=
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=l
    set guioptions-=L
    if has("win32")
        set guifont=Fantasque_Sans_Mono:h12
    else
        set guifont=Fantasque\ Sans\ Mono\ 12
    endif
    set background=dark
    colorscheme PaperColor
    hi pythonDocstring gui=None guifg=#AB976F
    hi StatusLine gui=reverse guifg=#5F8787 guibg=#1C1C1C
    set cursorline
    set cursorcolumn
endif

" Configure the statusline.
highlight StatusLineModeNormal guibg=#5FAFD7 guifg=#1C1C1C
highlight StatusLineModeInsert guibg=#AFD700 guifg=#1C1C1C
highlight StatusLineModeReplace guibg=#FF5FAF guifg=#1C1C1C
highlight StatusLineModeVisual guibg=#D7AF00 guifg=#1C1C1C
highlight StatusLineModeSelect guibg=#AF87D7 guifg=#1C1C1C
highlight StatusLineModeTerminal guibg=#808080 guifg=#1C1C1C
let g:modes={
    \ "n": ["NORMAL","StatusLineModeNormal"],
    \ "i": ["INSERT","StatusLineModeInsert"],
    \ "R": ["REPLACE","StatusLineModeReplace"],
    \ "v": ["VISUAL","StatusLineModeVisual"],
    \ "V": ["V-LINE","StatusLineModeVisual"],
    \ "\<C-v>": ["V-BLOCK","StatusLineModeVisual"],
    \ "c": ["COMMAND","StatusLineModeCommand"],
    \ "s": ["SELECT","StatusLineModeSelect"],
    \ "S": ["S-LINE","StatusLineModeSelect"],
    \ "\<C-s>": ["S-BLOCK","StatusLineModeSelect"],
    \ "t": ["TERMINAL","StatusLineModeTerminal"]
    \ }
function! BuildStatusLine()
    let statusline="%#" . get(g:modes,mode(),['','StatusLineModeNormal'])[1] . "#"
    let statusline.="\ %-8{get(g:modes,mode(),['',''])[0]}\ "
    let statusline.="%*"
    let statusline.="\ %f\ %m\ %r"
    let statusline.="%="
    let statusline.="%y"
    let statusline.="\ %5l:%-5c\ "
    return statusline
endfunction
set statusline=%!BuildStatusLine()

" Fix to make gvim window as large as possible without the white borders on my
" Windows system. Does leave a small gap around the edge, but that's the
" lesser evil.
function! WinSize(cols, rows, xpos, ypos)
    let &columns=a:cols
    let &lines=a:rows
    execute "winpos " . a:xpos . " " . a:ypos
endfunction
map <C-Up> :call WinSize(230, 57, 63, 11)<CR>
map <C-Left> :call WinSize(114, 57, 63, 11)<CR>
map <C-Right> :call WinSize(114, 57, 990, 11)<CR>

" Jump to the last position when re-opening a file.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

