" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝

" https://github.com/b4skyx/dotfiles

let mapleader =","
let maplocalleader = "\\"


" Vim-Plug init
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" Vim-Plug Plugins

call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'

Plug 'phaazon/hop.nvim'

Plug 'godlygeek/tabular'
Plug 'b3nj5m1n/kommentary'

Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
Plug 'vimwiki/vimwiki'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'
" Plug 'onsails/lspkind-nvim'

Plug 'windwp/nvim-autopairs'
Plug 'sheerun/vim-polyglot'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

