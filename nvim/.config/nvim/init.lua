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
vim.o.showbreak="<b> "

-- local to window
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true
vim.wo.colorcolumn = "90"
vim.wo.signcolumn = "yes"

-- local to buffer
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.smartindent = true

vim.opt.undofile = true
vim.g.undodir ="~/.cache/nvim/undodir"

require('packer').startup(function()
  -- packer manage itself
  use 'wbthomason/packer.nvim'

  -- Wallpaper
  use "Shatur/neovim-ayu"
  use 'tiagovla/tokyodark.nvim'
  -- use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  -- use "rebelot/kanagawa.nvim"

  use 'kyazdani42/nvim-web-devicons'
  -- use 'flazz/vim-colorschemes'            
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function() require('statusline-config') end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use 'vimwiki/vimwiki'

  -- Languages
  use 'fatih/vim-go'
  use 'mxw/vim-jsx'
  -- use 'rust-lang/rust.vim'
  -- use 'pangloss/vim-javascript'
  use 'simrat39/rust-tools.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'    -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp'         -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'     -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'         -- Snippets plugin
  use "rafamadriz/friendly-snippets"

  -- TS/JS
  use "jose-elias-alvarez/null-ls.nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Utils 
  -- plugins from the saint TPOPE
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary' -- comment features
  use 'tpope/vim-fugitive'   -- git features
  use 'tpope/vim-rhubarb'    -- github feature for gitfugitive
  use 'ggandor/leap.nvim' 
  use 'unblevable/quick-scope'
  use 'junegunn/vim-easy-align'
  use 'norcalli/nvim-colorizer.lua'
  use 'mbbill/undotree'
  use ({ 'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })
  use {"andymass/vim-matchup", event = "BufRead"}
  use 'vuciv/vim-bujo' -- take notes

  -- Telescope
  use ({ 
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
  })
  use 'nvim-telescope/telescope-project.nvim'

  -- File explorer
  use 'tamago324/lir.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Other
  use 'ThePrimeagen/harpoon' 

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


  -- use "rcarriga/nvim-notify"
  use "jbyuki/venn.nvim"      -- ascii drawing
  use "segeljakt/vim-silicon" -- silicon carbon.sh like feature
  use({ "yioneko/nvim-yati", requires = "nvim-treesitter/nvim-treesitter" })
  use { 'lewis6991/gitsigns.nvim', config = function() 
      require('gitsigns').setup() end
  }
end)

-- aliases
local cmd = vim.cmd

cmd 'colorscheme ayu-dark'
cmd 'highlight colorcolumn guibg=#ff7986'

-- plugin configuration
require('telescope-config')
require('vimwiki-config')
require('autocompletion-config')
require('treesitter-config')
require('alpha-config')
require('file-explorer-config')
require('keymaps') -- keymaps

-- plugin setup
require('colorizer').setup()
require('leap').add_default_mappings()
require("nvim-treesitter.configs").setup {
  yati = { enable = true },
}

-- RUST-TOOLS
--
local opts = {
  tools = { 
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = {
    settings = {
      ["rust-analyzer"] = {
	-- enable clippy on save
	checkOnSave = {
	  command = "clippy"
	},
      }
    }
  },
}
require('rust-tools').setup(opts)

-- cmd 'source ~/.config/nvim/utils.vim'

--- ASCII DRAWING PLUGIN
--
-- venn.nvim: enable or disable keymappings
--
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd[[setlocal ve=all]]
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
  else
    vim.cmd[[setlocal ve=]]
    vim.cmd[[mapclear <buffer>]]
    vim.b.venn_enabled = nil
  end
end

vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

