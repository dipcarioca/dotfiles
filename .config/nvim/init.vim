syntax enable
set noerrorbells
set autoindent
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set noswapfile
set incsearch
set hlsearch
set whichwrap+=<,>,[,]
set noshowmode
set cmdheight=1
set laststatus=1
set termguicolors
set t_Co=256
set shell=/bin/fish

" 2. Carrega as definições do Wal
if filereadable(expand('~/.cache/wal/colors-wal.vim'))
    source ~/.cache/wal/colors-wal.vim
endif

highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight Comment gui=italic ctermfg=14
highlight Constant ctermfg=12
highlight String ctermfg=10
highlight Identifier ctermfg=9
highlight Function ctermfg=11
highlight Statement ctermfg=13
highlight PreProc ctermfg=15
highlight Type ctermfg=14
highlight Special ctermfg=12

source $HOME/.config/nvim/vim-plug/plugins.vim
