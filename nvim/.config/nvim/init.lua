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


-- Keymaps
-- vim.api.nvim.set_keymap({mode}, {keymap}, {mapped_to}, {options})
local keymap = vim.api.nvim_set_keymap
-- keymap('','','', {})

local opts = { noremap = true }
-- no arrow keys
keymap('n','<Up>','<Nop>', opts)
keymap('n','<Down>','<Nop>', opts)
keymap('n','<Left>','<Nop>', opts)
keymap('n','<Right>','<Nop>', opts)

keymap('n','<C-j>','<C-w>j', opts)
keymap('n','<C-h>','<C-w>h', opts)
keymap('n','<C-k>','<C-w>k', opts)
keymap('n','<C-l>','<C-w>l', opts)


require('packer').startup(function()
  -- packer manage itself
  use 'wbthomason/packer.nvim'

  use 'flazz/vim-colorschemes'            

  use 'vimwiki/vimwiki'

  -- utils 
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'norcalli/nvim-colorizer.lua'
  use 'mbbill/undotree'
  use 'unblevable/quick-scope'
  use 'junegunn/vim-easy-align'
  use ({ 'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha-config')
    end,
  })

end)

local cmd = vim.cmd

cmd 'colorscheme gruvbox'
cmd 'highlight colorcolumn guibg=#ff7986'

--- vimwiki
vim.g.vimwiki_list = {
  {
    path = '~/babidi-wiki/',
    syntax = 'markdown',
    ext = '.md'
  }
}
vim.g.vimwiki_ext2syntax = {
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown',
}



-- if vim.loop.os_uname().sysname == 'Linux'

