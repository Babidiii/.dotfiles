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
-- vim.o.background = "dark"


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

-- other
vim.g.rustfmt_autosave = 1

vim.opt.undofile = true
vim.g.undodir ="~/.cache/nvim/undodir"

require('packer').startup(function()
  -- packer manage itself
  use 'wbthomason/packer.nvim'

  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use "Shatur/neovim-ayu"
  use "rebelot/kanagawa.nvim"
  use 'tiagovla/tokyodark.nvim'
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

  -- utils 
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive' -- git    features
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

  -- File explorer
  use 'tamago324/lir.nvim'
  use 'nvim-lua/plenary.nvim'

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
  use 'vuciv/vim-bujo'


  -- ascii drawing
  use "jbyuki/venn.nvim"
  -- silicon 
  use "segeljakt/vim-silicon"
end)

-- aliases
local cmd = vim.cmd

-- colorscheme
vim.cmd("colorscheme kanagawa")
cmd 'highlight colorcolumn guibg=#ff7986'

-- plugin configuration
require('colorizer').setup()

require('telescope-config')
require('vimwiki-config')
require('autocompletion-config')
require('treesitter-config')
require('alpha-config')
require('file-explorer-config')

-- keymaps
require('keymaps')

-- if vim.loop.os_uname().sysname == 'Linux'

-- cmd 'source ~/.config/nvim/utils.vim'


-- local files = {
--   python = "python3 -i " .. exp("%:t"),
--   lua = "lua " .. exp("%:t"),
--   c = "gcc -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
--   cpp = "clang++ -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
--   java = "javac " .. exp("%:t") .. " && java " .. exp("%:t:r") .. " && rm *.class",
--   rust = "cargo run",
--   javascript = "node " .. exp("%:t"),
--   typescript = "tsc " .. exp("%:t") .. " && node " .. exp("%:t:r") .. ".js",
-- }
-- function Run_file()
--   local command = files[vim.bo.filetype]
--   if command ~= nil then
--     Open_term:new({ cmd = command, close_on_exit = false }):toggle()
--     print("Running: " .. command)
--   end
-- end
--

-- venn.nvim: enable or disable keymappings
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
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})
