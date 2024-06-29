local Plug = vim.fn['plug#']

 vim.call('plug#begin')
     Plug 'preservim/nerdtree'
     Plug 'neovim/nvim-lspconfig'
     Plug 'hrsh7th/cmp-nvim-lsp'
     Plug 'hrsh7th/cmp-buffer'
     Plug 'hrsh7th/cmp-path'
     Plug 'hrsh7th/cmp-cmdline'
     Plug 'hrsh7th/nvim-cmp'
     Plug 'hrsh7th/cmp-vsnip'
     Plug 'hrsh7th/vim-vsnip'
     Plug 'tiagovla/tokyodark.nvim'
     Plug 'junegunn/fzf.vim'
     Plug 'rafamadriz/friendly-snippets'
     Plug 'nvim-lua/plenary.nvim'
     Plug 'sindrets/diffview.nvim'
     Plug 'NeogitOrg/neogit'
vim.call('plug#end')

vim.cmd [[colorscheme tokyodark]]

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.o.relativenumber = true
-- Make signcolumn always present so text is not constantly shifting when signs appear and disappear
vim.o.signcolumn = "yes"

require("global-keymap")
require("nvim-cmp")
require("nvim-lspconfig")
require("neogit").setup {}
