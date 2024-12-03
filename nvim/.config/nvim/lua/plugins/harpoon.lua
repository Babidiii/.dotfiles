-- ------------------------------------------------------------------------
-- Harpoon plugin
-- links: https://github.com/ThePrimeagen/harpoon
-- ------------------------------------------------------------------------

return {
	"ThePrimeagen/harpoon",
	config = function()
		-- aliases
		-- vim.api.nvim.set_keymap({mode}, {keymap}, {mapped_to}, {options})
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true }

		-- Harpoon navigates to next/previous mark
		map('n', '<C-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<CR><cmd>', opts)
		map('n', '<C-j>', '<cmd>require("harpoon.ui").nav_file(2)<CR><cmd>', opts)
		map('n', '<C-k>', '<cmd>require("harpoon.ui").nav_file(3)<CR><cmd>', opts)
		map('n', '<C-l>', '<cmd>require("harpoon.ui").nav_file(4)<CR><cmd>', opts)

		-- Harpoon shortcut to commands
		map('n', '<M-1>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 1)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-2>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 2)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-3>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 3)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-4>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 4)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-5>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 6)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-6>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 7)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)
		map('n', '<M-7>',
			'<cmd>lua require("harpoon.term").sendCommand(1, 8)<CR> <bar> <cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>',
			opts)

		-- Harpoon toggle menu
		map('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
		map('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
		map('n', '<C-q>', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', opts)

		-- Harpoon go to terminal one
		map('n', '<leader>ht', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
	end
}
