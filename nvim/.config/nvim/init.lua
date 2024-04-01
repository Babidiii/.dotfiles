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
vim.o.showbreak="<b> "
vim.o.title= true

-- local to window
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true
-- vim.wo.colorcolumn = "90"
vim.wo.signcolumn = "yes"

-- local to buffer
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.smartindent = true

vim.opt.undofile = true
vim.g.undodir ="~/.cache/nvim/undodir"

-----------------------------------------------------------------------------------
-- Packer
-----------------------------------------------------------------------------------
local ensure_lazy_packer = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
end

ensure_lazy_packer()

-- [ Leader key ]
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("lazy").setup({ {import = "plugins"},{import = "plugins.lsp"}});


-- require("packer").startup(function()
--   use "lewis6991/impatient.nvim"

--   -- Colorscheme
--   use "Shatur/neovim-ayu"
--   use "tiagovla/tokyodark.nvim"
--   use "rebelot/kanagawa.nvim"

--   use "tamago324/lir.nvim" -- file explorer

-- 	use 'folke/trouble.nvim' -- Summarizes issues
-- 	use "kyazdani42/nvim-web-devicons"
-- 	use {
-- 		'nvim-lualine/lualine.nvim',
-- 		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
-- 	}
-- 	use 'arkav/lualine-lsp-progress'
--   -- use {
--   --   "glepnir/galaxyline.nvim",
--   --   branch = "main",
--   --   config = function() require("statusline-config") end,
--   --   requires = {"kyazdani42/nvim-web-devicons", opt = true}
--   -- }
--   use ({ "goolord/alpha-nvim",
--     requires = { "kyazdani42/nvim-web-devicons" },
--   })

--   -- LSP & Snippets
--   use "neovim/nvim-lspconfig"    -- Collection of configurations for built-in LSP client
--   use "hrsh7th/nvim-cmp"         -- Autocompletion plugin
--   use "hrsh7th/cmp-nvim-lsp"     -- LSP source for nvim-cmp
--   use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
--   use "L3MON4D3/LuaSnip"         -- Snippets plugin
--   use "rafamadriz/friendly-snippets"

-- 	use({
-- 		'weilbith/nvim-code-action-menu',
-- 		cmd = 'CodeActionMenu',
-- 	})

--   -- Treesitter
--   use {
--     "nvim-treesitter/nvim-treesitter",
--     run = ":TSUpdate"
--   }
--   use "nvim-treesitter/playground"
--   use "nvim-treesitter/nvim-treesitter-textobjects"

--   -- TPOPE plugins
--   use "tpope/vim-commentary" -- comment features
--   use "tpope/vim-fugitive"   -- git features
--   use "tpope/vim-rhubarb"    -- github feature for gitfugitive
--   -- use "tpope/vim-surround"

--   -- Utils
--   use "mbbill/undotree"
--   use "unblevable/quick-scope" 
--   use "machakann/vim-sandwich" -- alt for vim-surround
--   use "junegunn/vim-easy-align"
--   use "norcalli/nvim-colorizer.lua"
--   use {"andymass/vim-matchup", event = "BufRead"} -- extends vim's %
--   use "vimwiki/vimwiki"				  
--   use "vuciv/vim-bujo"         			  -- take notes
--   use "jbyuki/venn.nvim"       			  -- ascii drawing
--   use "segeljakt/vim-silicon"  			  -- silicon carbon.sh like feature
--   use {
--     "folke/todo-comments.nvim",
--     requires = "nvim-lua/plenary.nvim",
-- 		opt=false,
--     config = function()
--       require("todo-comments").setup {
--       }
--     end
--   }

--   -- Telescope
--   use ({ 
--     "nvim-telescope/telescope.nvim",
--     requires = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
--   })
--   -- use "nvim-telescope/telescope-project.nvim" -- project telescope extension

--   -- Other
--   -- use "rcarriga/nvim-notify" -- notification manager
--   use "ThePrimeagen/harpoon" 
--   -- highlight arguments
--   use { 'm-demare/hlargs.nvim', requires = { 'nvim-treesitter/nvim-treesitter' } }
--   use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })
--   use { "lewis6991/gitsigns.nvim", config = function() 
--       require("gitsigns").setup() end
--   }

--  use {
--     'saecki/crates.nvim',
--     tag = 'v0.3.0',
--     requires = { 'nvim-lua/plenary.nvim' },
--     config = function()
--         require('crates').setup()
--     end,
-- }
--   -- Rust specific
--   use "simrat39/rust-tools.nvim"
--   use ({
--     'babidiii/rust-cfg.nvim',
--     requires = {
--       'nvim-telescope/telescope.nvim', 
--       'nvim-lua/plenary.nvim', 
--       'simrat39/rust-tools.nvim', 
--     },
--     opt = false,
--     config = function() 
--       require('telescope').load_extension('rust_cfg') 
--     end
--   })

-- end)

-----------------------------------------------------------------------------------
-- Configuration
-----------------------------------------------------------------------------------

-- aliases
local cmd = vim.cmd

cmd "colorscheme kanagawa"
cmd "highlight colorcolumn guibg=#ff7986"
cmd "source ~/.config/nvim/utils.vim"

-- plugin configuration
require("impatient")

-- custom configs

require("autogroups")
require("keymaps")               -- keymaps

-- require("telescope-config")
-- require("colorizer").setup()

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = false
vim.g.code_action_menu_show_action_kind = false	

