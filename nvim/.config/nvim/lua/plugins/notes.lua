-- ============================================================================
-- Notes & Documentation
-- Note-taking, wikis, and image pasting tools
-- ============================================================================

return {
	-- ========================================================================
	-- VimWiki - Personal wiki
	-- ========================================================================
	"vimwiki/vimwiki",
	
	-- ========================================================================
	-- Bujo - Bullet journal
	-- ========================================================================
	"vuciv/vim-bujo",
	
	-- ========================================================================
	-- ZK - Zettelkasten note-taking
	-- ========================================================================
	{
		"zk-org/zk-nvim",
		cmd = { "ZkNew", "ZkNotes" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("zk").setup({})
			
			-- Define key mappings
			local opts = { noremap = true, silent = false }
			vim.api.nvim_set_keymap("n", "<leader>zn", ":ZkNew<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>zf", ":ZkNotes<CR>", opts)
		end,
	},
	
	-- ========================================================================
	-- Image Clipboard - Paste images from clipboard
	-- ========================================================================
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			template = "$FILE_PATH",
			url_encode_path = false,
			relative_template_path = true,
			use_cursor_in_template = true,
			insert_mode_after_paste = true,
			
			filetypes = {
				markdown = {
					url_encode_path = true,
					template = "![$CURSOR]($FILE_PATH)",
					download_images = false,
				},
			},
			
			dirs = {
				["~/notes/fullstackfullnotes/"] = {
					dir_path = function()
						local full_path = vim.fn.expand("%:p")
						local relative_path = full_path:match("content/notes/(.+)%.md$")
						if not relative_path then
							return "Error: File not in content/notes/ or not a .md file"
						end
						return "static/images/" .. relative_path
					end,
					template = function()
						local full_path = vim.fn.expand("%:p")
						local relative_path = full_path:match("content/notes/(.+)%.md$")
						local path = "/images/" .. relative_path
						return "{{ figure(src=\"" .. path .. "/$FILE_NAME\", alt='$FILE_NAME', caption='$FILE_NAME') }}"
					end
				},
			},
		},
		keys = {
			{ "<leader>n", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
	
	-- ========================================================================
	-- Silicon - Code screenshots
	-- ========================================================================
	"segeljakt/vim-silicon",
	
	-- ========================================================================
	-- Todo Comments - Highlight and search TODO comments
	-- ========================================================================
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		cmd = { "TodoTrouble", "TodoLocList", "TodoQuickFix", "TodoTelescope" },
		keys = {
			{
				"<leader>fT",
				"<cmd>TodoTelescope<cr>",
				desc = "Todo | Telescope",
				silent = true
			}
		},
		opts = {
			signs = true,
			sign_priority = 8,
			keywords = {
				FIX = {
					icon = " ",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = "󰥔 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = "󱞁 ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE",
				bg = "BOLD",
			},
			merge_keywords = true,
			highlight = {
				multiline = true,
				multiline_pattern = "^.",
				multiline_context = 10,
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
				comments_only = true,
				max_line_len = 400,
				exclude = {},
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		},
	},
}
