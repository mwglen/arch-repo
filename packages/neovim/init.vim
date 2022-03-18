call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'jacoborus/tender.vim'
Plug 'LnL7/vim-nix'
Plug 'rust-lang/rust.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
call plug#end()

set number relativenumber       " set line-numbers to be relative
set nohlsearch                  " no highlight search
set mouse=a                     " recognize and enable mouse
set tabstop=4                   " show existing tab as 4 spaces
set shiftwidth=4                " use 4 spaces when indenting with '>'
set expandtab                   " on pressing tab, insert 4 spaces
set termguicolors               " use terminal colors
set ignorecase
set smartcase
set nobackup
let g:airline_powerlin_fonts=1  " set airline theme
colorscheme tender              " change the colorscheme
let g:airline_theme = 'tender'  " change airline colorscheme

# Colors
let bg = "#000000"
let fg = "#d5d8d6"

let base0 = "#0d0d0d"
let base1 = "#1b1b1b"
let base2 = "#212122"
let base3 = "#292b2b"
let base4 = "#3f4040"
let base5 = "#5c5e5e"
let base6 = "#757878"
let base7 = "#969896"
let base8 = "#ffffff"

let black     = "#000000"
let white     = "#ffffff"
let grey      = "#5a5b5a" 
let red       = "#cc6666" 
let orange    = "#de935f"
let yellow    = "#f0c674"
let green     = "#b5bd68"
let blue      = "#81a2be"
let teal      = "#81a2be"
let magenta   = "#c9b4cf"
let violet    = "#b294bb"
let cyan      = "#8abeb7"

execute "hi! Normal guibg=" . bg
execute "hi! String guifg=" . green
execute "hi! Keyword guifg=" . violet
execute "hi! Type guifg=" . yellow
execute "hi! Operator guifg=" . fg
execute "hi! Number guifg=" . orange
execute "hi! Function guifg=" . blue
execute "hi! Constant guifg=" . orange
execute "hi! Comment guifg=" . grey
execute "hi! Conditional guifg=" . violet
