-- options configuration
--   vim.o  -> global options
--   vom.wo -> local to window
--   vom.bo -> local to buffer

-- global
vim.o.hidden = true
vim.o.errorbells = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.termguicolors = true
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.guicursor = ""
vim.o.scrolloff = 8
vim.o.smartcase = true
vim.o.background = "dark"

-- local to window
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false
vim.wo.colorcolumn = "90"
vim.wo.signcolumn = "yes"

-- local to buffer
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.smartindent = true


require('packer').startup(function()
  -- packer manage itself
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'            

  use 'vimwiki/vimwiki'

  -- language
  use 'fatih/vim-go'
  use 'mxw/vim-jsx'
  use 'rust-lang/rust.vim'
  -- use 'pangloss/vim-javascript'

  -- LSP
  use 'neovim/nvim-lspconfig'    -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp'         -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'         -- Snippets plugin

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- utils 
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive' -- git features
  use 'tpope/vim-rhubarb'  -- github feature for gitfugitive
  use 'norcalli/nvim-colorizer.lua'
  use 'mbbill/undotree'
  use 'unblevable/quick-scope'
  use 'junegunn/vim-easy-align'
  use ({ 'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })

  -- Telescope
  use ({ 
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
  })
  use 'nvim-telescope/telescope-project.nvim'

  -- Other
  use 'ThePrimeagen/harpoon' 
  use {
    "andymass/vim-matchup",
    event = "BufRead"
  }

  use 'lewis6991/impatient.nvim'
  use {
    "Pocco81/TrueZen.nvim",
    cmd = {
      "TZFocus",
      "TZAtaraxis",
      "TZMinimalist",
    },
    setup = function()
      require("truezen-config")
    end
  }


  -- useful
  -- use 'junegunn/goyo.vim'
  -- use 'vuciv/vim-bujo'
end)

-- aliases
local cmd = vim.cmd

-- colorscheme
cmd 'colorscheme gruvbox'
cmd 'highlight colorcolumn guibg=#ff7986'

-- plugin configuration
require('colorizer').setup()

require('telescope-config')
require('vimwiki-config')
require('autocompletion-config')
require('treesitter-config')
require('alpha-config')

-- keymaps
require('keymaps')

-- if vim.loop.os_uname().sysname == 'Linux'
