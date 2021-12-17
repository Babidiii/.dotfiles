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
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
 
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

  -- Extra
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/popup.nvim'
  use 'ThePrimeagen/harpoon' 

  -- useful
  -- use 'junegunn/goyo.vim'
  -- use 'vuciv/vim-bujo'
end)

require'nvim-treesitter.configs'.setup {highlight = { enable = true }}
require'colorizer'.setup()

-- ALIASES
local map = vim.api.nvim_set_keymap -- vim.api.nvim.set_keymap({mode}, {keymap}, {mapped_to}, {options})
local opts = { noremap = true }
local cmd = vim.cmd

-- Leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

-- KEYMAPS
-- no arrow keys
map('n','<Up>','<Nop>', opts)
map('n','<Down>','<Nop>', opts)
map('n','<Left>','<Nop>', opts)
map('n','<Right>','<Nop>', opts)

map('n','<C-j>','<C-w>j', opts)
map('n','<C-h>','<C-w>h', opts)
map('n','<C-k>','<C-w>k', opts)
map('n','<C-l>','<C-w>l', opts)

map('v','<leader>p','_dP', opts)
map('v','<leader>d','_d', opts)
map('n','<leader>d','_d', opts)

map('n','<leader>y','"+y', opts)
map('v','<leader>y','"+y', opts)
map('n','<leader>Y','gg"+yG', opts)

map('n','<leader>u',':UndotreeShow<CR>', opts)
map('n','<leader><CR>',':so ~/.config/nvim/init.lua<CR>', opts)

map('n','<leader>pv',':Explore<CR>', opts)

-- selection
map('n','Y','y$', opts)
map('n','n','nzzzv', opts)
map('n','N','Nzzzv', opts)
map('n','J','mzJ`z', opts)

-- undo break points
map('i',',',',<c-g>u', opts)
map('i','!','!<c-g>u', opts)
map('i','.','.<c-g>u', opts)
map('i','?','?<c-g>u', opts)

-- ctrl o and ctrl i flow from k and j jump 
-- map('n','<expr>','?<c-g>u', opts)
-- nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
-- nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

-- moving block cursor in any mode
map('v','J',':m \'>+1<CR>gv=gv', opts)
map('i','<C-j>','<esc>:m .+1<CR>==i', opts)
map('v','K',':m \'<-2<CR>gv=gv', opts)
map('i','<C-k>','<esc>:m .-2<CR>==i', opts)
map('n','<leader>j',':m .+1<CR>==', opts)
map('n','<leader>k',':m .-2<CR>==', opts)

-- cargo
map('n','<leader>cc',':!cargo clippy', opts)
map('n','<leader>cr',':!cargo run', opts)

-- fugitive
map('n','<leader>gs',':G<CR>', {})
map('n','<leader>gj',':diffget //3<CR>', {})
map('n','<leader>gf',':diffget //2<CR>', {})

-- terminal
map('t','<Esc><Esc>','<C-\\><C-n>', opts)

map('t','<M-h>','<c-\\><c-n><c-w>h', opts)
map('t','<M-j>','<c-\\><c-n><c-w>j', opts)
map('t','<M-k>','<c-\\><c-n><c-w>k', opts)
map('t','<M-l>','<c-\\><c-n><c-w>l', opts)

-- easy align
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('x', 'ga', '<Plug>(EasyAlign)',{})
map('n', 'ga', '<Plug>(EasyAlign)',{})

-- Find files using Telescope command-line sugar.
map('n','<leader>ff','<cmd>Telescope find_files<cr>',opts)
map('n','<leader>fg','<cmd>Telescope live_grep<cr>',opts)
map('n','<leader>fs','<cmd>Telescope git_branches<cr>',opts)
map('n','<leader>fb','<cmd>Telescope buffers<cr>',opts)
map('n','<leader>fh','<cmd>Telescope help_tags<cr>',opts)
map('n','<leader>fl','<cmd>Telescope loclist<cr>',opts)
map('n','<leader>fc','<cmd>Telescope quickfix<cr>',opts)
map('n','<leader>fu','<cmd>Telescope git_files<cr>',opts)
-- Show code action 
map('n','ca',':Telescope lsp_code_actions<CR>', { noremap = false, silent= true})

-- harpoon
map('n','<M-1>',':lua require("harpoon.term").sendCommand(1, 1)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-2>',':lua require("harpoon.term").sendCommand(1, 2)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-3>',':lua require("harpoon.term").sendCommand(1, 3)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-4>',':lua require("harpoon.term").sendCommand(1, 4)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-5>',':lua require("harpoon.term").sendCommand(1, 6)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-6>',':lua require("harpoon.term").sendCommand(1, 7)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-7>',':lua require("harpoon.term").sendCommand(1, 8)<CR> <bar> :lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)

-- toggle menu
map('n', '<leader>mv', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts) -- mv for move to overview
map('n','<leader>hc',':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', opts)
map('n','<leader>hf',':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
-- Go to terminal one
map('n','<leader>ht',':lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
-- navigates to next/previous mark
map('n','<leader>hn',':lua require("harpoon.ui").nav_next()<CR>',opts)
map('n','<leader>hb',':lua require("harpoon.ui").nav_prev()<CR>',opts)   
-- add/delete mark
map('n', '<leader>mm', ':lua require("harpoon.mark").add_file()<CR>', opts) -- mm means fast adding files to belly
map('n', '<leader>mc', ':lua require("harpoon.mark").clear_all()<CR>', opts) -- mc means fast puking away files

------------------- LSP
-- info
map('n','<leader>vD',':lua vim.lsp.buf.declaration()<CR>',opts)
-- map('n','<leader>vdt',':lua vim.lsp.buf.type_definition()<CR>',opts)
map('n','<leader>vd',':lua vim.lsp.buf.definition()<CR>',opts)
map('n','<leader>vr',':lua vim.lsp.buf.references()<CR>',opts)
map('n','<leader>vK ',':lua vim.lsp.buf.hover()<CR>',opts)
map('n','<leader>vi',':lua vim.lsp.buf.implementation()<CR>',opts)
map('n','<leader>vsh',':lua vim.lsp.buf.signature_help()<CR>',opts)
-- actions
map('n','<leader>vrn',':lua vim.lsp.buf.rename()<CR>',opts)
map('n','<leader>vca',':lua vim.lsp.buf.code_action()<CR>',opts)
-- workspace
map('n','<leader>vwa',':lua vim.lsp.buf.add_workspace_folder()<CR>',opts)
map('n','<leader>vwr',':lua vim.lsp.buf.remove_workspace_folder()<CR>',opts)
map('n','<leader>vwl',':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',opts)
-- diagnostic
map('n','<leader>ve',':lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',opts)
map('n','<leader>vn',':lua vim.lsp.diagnostic.goto_prev()<CR>',opts)
map('n','<leader>vp',':lua vim.lsp.diagnostic.goto_next()<CR>',opts)
map('n','<leader>vq',':lua vim.lsp.diagnostic.set_loclist()<CR>',opts)
-- format
map('n','<leader>vf',':lua vim.lsp.buf.formatting()<CR>',opts)
 
map('n','<C-n>',':cnext<CR>',opts)
map('n','<C-p>',':cprev<CR>',opts)

cmd 'colorscheme gruvbox'
cmd 'highlight colorcolumn guibg=#ff7986'

require('vimwiki-config')
require('lsp-config')
require('autocompletion-config')

-- if vim.loop.os_uname().sysname == 'Linux'
