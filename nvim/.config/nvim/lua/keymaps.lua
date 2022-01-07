--------------------------------------------- KEYMAPS
-- aliases
-- vim.api.nvim.set_keymap({mode}, {keymap}, {mapped_to}, {options})
local map = vim.api.nvim_set_keymap 
local opts = { noremap = true}

-- Leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- No arrow keys
map('n','<Up>','<Nop>', opts)
map('n','<Down>','<Nop>', opts)
map('n','<Left>','<Nop>', opts)
map('n','<Right>','<Nop>', opts)

-- Window movement
map('n','<C-j>','<C-w>j', opts)
map('n','<C-h>','<C-w>h', opts)
map('n','<C-k>','<C-w>k', opts)
map('n','<C-l>','<C-w>l', opts)

-- BLANK Copy and delete
map('v','<leader>p','_dP', opts)
map('v','<leader>d','_d', opts)
map('n','<leader>d','_d', opts)

-- Clipboard
map('n','<leader>y','"+y', opts)
map('v','<leader>y','"+y', opts)
map('n','<leader>Y','gg"+yG', opts)

map('n','<leader>u','<cmd>UndotreeToggle<CR>', opts)

map('n','<leader><CR>',[[:source ~/.config/nvim/init.lua<CR>]], {noremap = true })

-- map('n','<leader>pv','<cmd>Explore<CR>', opts)
map('n','<leader>pv',[[:lua require('lir.float').toggle()<CR>]], opts)

-- Fast search
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

-- Moving block cursor in any mode
map('v','J',[[:m '>+1<CR>gv=gv]], opts)
map('v','K',[[:m '<-2<CR>gv=gv]], opts)
map('i','<C-j>','<esc><cmd>m .+1<CR>==i', opts)
map('i','<C-k>','<esc><cmd>m .-2<CR>==i', opts)
map('n','<leader>j','<cmd>m .+1<CR>==', opts)
map('n','<leader>k','<cmd>m .-2<CR>==', opts)

-- Cargo
map('n','<leader>cc','<cmd>Cargo clippy<CR>', opts)
map('n','<leader>cr','<cmd>Cargo run<CR>', opts)

-- Git Fugitive
map('n','<leader>gs','<cmd>G<CR>', {})
map('n','<leader>gj','<cmd>diffget //3<CR>', {})
map('n','<leader>gf','<cmd>diffget //2<CR>', {})

-- Terminal escape
map('t','<Esc><Esc>','<C-\\><C-n>', opts)
-- Terminal windows movement
map('t','<M-h>','<c-\\><c-n><c-w>h', opts)
map('t','<M-j>','<c-\\><c-n><c-w>j', opts)
map('t','<M-k>','<c-\\><c-n><c-w>k', opts)
map('t','<M-l>','<c-\\><c-n><c-w>l', opts)

-- Easy align plugin (e.g. gaip)
map('x', 'ga', '<Plug>(EasyAlign)',{})
map('n', 'ga', '<Plug>(EasyAlign)',{})

-- Telescope
map('n','<leader>ff','<cmd>Telescope find_files<cr>',opts)
map('n','<leader>fg','<cmd>Telescope live_grep<cr>',opts)
map('n','<leader>fs','<cmd>Telescope git_branches<cr>',opts)
map('n','<leader>fb','<cmd>Telescope buffers<cr>',opts)
map('n','<leader>fh','<cmd>Telescope help_tags<cr>',opts)
map('n','<leader>fl','<cmd>Telescope loclist<cr>',opts)
map('n','<leader>fc','<cmd>Telescope quickfix<cr>',opts)
map('n','<leader>fu','<cmd>Telescope git_files<cr>',opts)
map('n','<leader>fj',"<cmd>Telescope<CR>", {noremap = true, silent = true})
map('n','<leader>fp',"<cmd>lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})
map('n','ca','<cmd>Telescope lsp_code_actions<CR>', { noremap = false, silent= true})

-- Harpoon shortcut to commands
map('n','<M-1>','<cmd>lua require("harpoon.term").sendCommand(1, 1)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-2>','<cmd>lua require("harpoon.term").sendCommand(1, 2)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-3>','<cmd>lua require("harpoon.term").sendCommand(1, 3)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-4>','<cmd>lua require("harpoon.term").sendCommand(1, 4)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-5>','<cmd>lua require("harpoon.term").sendCommand(1, 6)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-6>','<cmd>lua require("harpoon.term").sendCommand(1, 7)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
map('n','<M-7>','<cmd>lua require("harpoon.term").sendCommand(1, 8)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)

-- Harpoon toggle menu
map('n','<leader>mv','<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts) -- mv for move to overview
map('n','<leader>hc','<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', opts)
map('n','<leader>hf','<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)

-- Harpoon go to terminal one
map('n','<leader>ht','<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)

-- Harpoon navigates to next/previous mark
map('n','<leader>hn','<cmd>lua require("harpoon.ui").nav_next()<CR>',opts)
map('n','<leader>hb','<cmd>lua require("harpoon.ui").nav_prev()<CR>',opts)   

-- Harpoon add/delete mark
map('n', '<leader>mm', '<cmd>lua require("harpoon.mark").add_file()<CR>', opts) -- mm means fast adding files to belly
map('n', '<leader>mc', '<cmd>lua require("harpoon.mark").clear_all()<CR>', opts) -- mc means fast puking away files

-- Quicklist next/prev
map('n','<C-n>','<cmd>cnext<CR>',opts)
map('n','<C-p>','<cmd>cprev<CR>',opts)

-- TrueZen
map('n','<leader>tz','<cmd>TZAtaraxis<CR>',opts)



map('n','<Leader>tu', '<Plug>BujoChecknormal', opts)
map('n','<Leader>th', '<Plug>BujoAddnormal', opts)
-- let g:bujo#todo_file_path = $HOME . "/.cache/bujo"
-- let g:bujo#window_width = 60

