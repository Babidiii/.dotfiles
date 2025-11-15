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
vim.o.showbreak = "<b> "
vim.o.title = true

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

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.undofile = true
vim.g.undodir = "~/.cache/nvim/undodir"
vim.diagnostic.config({ virtual_text = false })

-----------------------------------------------------------------------------------
-- Lazy
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

require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" } });

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
require("keymaps") -- keymaps

-- require("telescope-config")
-- require("colorizer").setup()

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = false
vim.g.code_action_menu_show_action_kind = false
