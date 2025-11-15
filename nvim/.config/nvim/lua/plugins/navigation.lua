-- ============================================================================
-- Navigation & Search
-- File navigation, fuzzy finding, and search tools
-- ============================================================================

return {
	-- ========================================================================
	-- Harpoon - Quick file navigation
	-- ========================================================================
	{
		"ThePrimeagen/harpoon",
		config = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true }
			
			-- Navigate to marked files
			map('n', '<C-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<CR><cmd>', opts)
			map('n', '<C-j>', '<cmd>require("harpoon.ui").nav_file(2)<CR><cmd>', opts)
			map('n', '<C-k>', '<cmd>require("harpoon.ui").nav_file(3)<CR><cmd>', opts)
			map('n', '<C-l>', '<cmd>require("harpoon.ui").nav_file(4)<CR><cmd>', opts)
			
			-- Send commands to terminal
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
			
			-- Toggle menus
			map('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>', opts)
			map('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
			map('n', '<C-q>', '<cmd>lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>', opts)
			
			-- Go to terminal
			map('n', '<leader>ht', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>i<CR>', opts)
		end
	},
	
	-- ========================================================================
	-- Telescope - Fuzzy finder
	-- ========================================================================
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
	},
	
	-- ========================================================================
	-- Snacks - Modern picker & file explorer
	-- ========================================================================
	{
		"folke/snacks.nvim",
		opts = {
			bigfile = { enabled = true },
			scope = { enabled = true },
			picker = {
				prompt = ' ',
				sources = {
					-- Explorer disabled - using lir instead
					-- explorer = {
					-- 	hidden = true,
					-- 	ignored = true,
					-- 	jump = {
					-- 		jumplist = true,
					-- 		tagstack = false,
					-- 		reuse_win = false,
					-- 		close = true,
					-- 		match = false,
					-- 	},
					-- 	layout = {
					-- 		reverse = false,
					-- 		preset = "telescope"
					-- 	},
					-- 	win = {
					-- 		list = {
					-- 			keys = {
					-- 				-- Navigation (like lir)
					-- 				["<BS>"] = "explorer_up",  -- Go to parent directory
					-- 				["h"] = "explorer_up",      -- Go up with h (vim-like)
					-- 				["l"] = "confirm",          -- Enter dir/open file with l
					-- 				["<CR>"] = "confirm",       -- Also with Enter
					-- 				
					-- 				-- File operations (like lir)
					-- 				["%"] = "explorer_add",     -- Create new file
					-- 				["d"] = "explorer_mkdir",   -- Create directory (if available)
					-- 				["D"] = "explorer_del",     -- Delete file/directory
					-- 				["r"] = "explorer_rename",  -- Rename
					-- 				["R"] = "explorer_rename",  -- Also R for rename
					-- 				
					-- 				-- Additional useful bindings
					-- 				["q"] = "close",            -- Quit
					-- 				["<Esc>"] = "close",        -- Also Esc
					-- 				["."] = "explorer_hidden",  -- Toggle hidden files
					-- 				["?"] = "help",             -- Show help
					-- 			}
					-- 		}
					-- 	},
					-- },
				},
			},
			explorer = {
				enabled = false,  -- Disabled - using lir instead
				-- config = {
				-- 	restrict_to_cwd = false,
				-- }
			}
		},
		keys = {
			-- Top Pickers (Snacks)
			{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
			{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
			
			-- Note: <leader>pv is now handled by lir (see lir config above)
			-- { "<leader>pv", ... } -- Removed - using lir instead
			-- { "<leader>PV", ... } -- Removed - using lir instead
			
			-- Find
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
			
			-- Git
			{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
			{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
			{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
			{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
			{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
			
			-- Grep
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
			
			-- Search
			{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
			{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
			{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
			{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
			
			-- LSP
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
			
			-- Utilities
			{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
			{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
			{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
			{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
			{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
			{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
			{ "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
			{ "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
			{ "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
			{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
		},
	},
	
	-- ========================================================================
	-- RipGrep Integration
	-- ========================================================================
	{
		'doums/rg.nvim',
		cmd = { 'Rg', 'Rgf', 'Rgp', 'Rgfp' },
	},
	
	-- ========================================================================
	-- Lir - File explorer with vim-like navigation
	-- ========================================================================
	{
		"tamago324/lir.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>pv", "<cmd>lua require('lir.float').toggle()<cr>", desc = "Lir File Explorer" },
		},
		config = function()
			local actions = require('lir.actions')
			local mark_actions = require('lir.mark.actions')
			local clipboard_actions = require('lir.clipboard.actions')
			
			require('lir').setup({
				show_hidden_files = true,
				devicons = {
					enable = true,
				},
				mappings = {
					['e'] = actions.edit,
					['s'] = actions.split,
					['v'] = actions.vsplit,
					['t'] = actions.tabedit,
					['h'] = actions.up,
					['l'] = actions.edit,
					['<CR>'] = actions.edit,
					['q'] = actions.quit,
					['<esc>'] = actions.quit,
					['d'] = actions.mkdir,
					['%'] = actions.newfile,
					['R'] = actions.rename,
					['@'] = actions.cd,
					['Y'] = actions.yank_path,
					['.'] = actions.toggle_show_hidden,
					['D'] = actions.delete,
					['J'] = function()
						mark_actions.toggle_mark()
						vim.cmd('normal! j')
					end,
					['C'] = clipboard_actions.copy,
					['X'] = clipboard_actions.cut,
					['P'] = clipboard_actions.paste,
				},
				float = {
					winblend = 3,
					curdir_window = {
						enable = true,
						highlight_dirname = true
					},
				},
				hide_cursor = false,
				on_init = function()
					-- Use visual mode for marking
					vim.api.nvim_buf_set_keymap(
						0,
						"x",
						"J",
						':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
						{ noremap = true, silent = true }
					)
					-- Echo current directory
					vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
				end,
			})
		end
	},
	
	-- ========================================================================
	-- Symbols Outline
	-- ========================================================================
	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},
}
