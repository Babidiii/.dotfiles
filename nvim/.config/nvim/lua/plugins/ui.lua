-- ============================================================================
-- UI & Visual Enhancements
-- Dashboard, statusline, notifications, colorschemes, and visual tools
-- ============================================================================

return {
	-- ========================================================================
	-- Dashboard / Start Screen
	-- ========================================================================
	{
		"goolord/alpha-nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			require("alpha.term")
			dashboard.config.opts.noautocmd = false
			
			local header = {
				"                                              ",
				" ██████╗  █████╗ ██████╗ ██╗██████╗ ██╗██╗██╗ ",
				" ██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗██║██║██║ ",
				" ██████╔╝███████║██████╔╝██║██║  ██║██║██║██║ ",
				" ██╔══██╗██╔══██║██╔══██╗██║██║  ██║██║██║██║ ",
				" ██████╔╝██║  ██║██████╔╝██║██████╔╝██║██║██║ ",
				" ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═════╝ ╚═╝╚═╝╚═╝ ",
				"                                        NVIM  ",
			}
			
			dashboard.section.header.val = header
			dashboard.section.header.opts.hl = "String"
			dashboard.section.buttons.val = {
				dashboard.button("e", "📝 New File", ":enew<CR>"),
				dashboard.button("f", "🔎 Find File", ":Telescope find_files<CR>"),
				dashboard.button("r", "⌛ Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("t", "📜 Find Text", ":Telescope live_grep<CR>"),
				dashboard.button("c", "⚙️ Config", ":edit ~/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "❌ Quit", ":qa<CR>"),
			}
			dashboard.section.footer.val = " - NVIM config by @Babidiii - "
			alpha.setup(dashboard.opts)
		end
	},
	
	-- ========================================================================
	-- Statusline
	-- ========================================================================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
		config = function()
			local config = require('lualine').get_config()
			config.extensions = { 'trouble', 'fugitive' }
			config.sections.lualine_c = { config.sections.lualine_c, 'lsp_progress' }
			require('lualine').setup(config)
		end
	},
	
	-- ========================================================================
	-- Notifications
	-- ========================================================================
	'rcarriga/nvim-notify',
	
	-- ========================================================================
	-- Colorschemes
	-- ========================================================================
	{
		"Shatur/neovim-ayu",
		lazy = true
	},
	{
		"tiagovla/tokyodark.nvim",
		lazy = true
	},
	"rebelot/kanagawa.nvim",
	
	-- ========================================================================
	-- Color Highlighting
	-- ========================================================================
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	
	-- ========================================================================
	-- Highlight Patterns
	-- ========================================================================
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
	},
	
	-- ========================================================================
	-- Icons
	-- ========================================================================
	"kyazdani42/nvim-web-devicons",
	
	-- ========================================================================
	-- Highlight Function Arguments
	-- ========================================================================
	{
		'm-demare/hlargs.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter' }
	},
	
	-- ========================================================================
	-- Visual Drawing Tool
	-- ========================================================================
	{
		"jbyuki/venn.nvim",
		config = function()
			-- Enable or disable keymappings for ASCII drawing
			function _G.Toggle_venn()
				local venn_enabled = vim.inspect(vim.b.venn_enabled)
				if venn_enabled == "nil" then
					vim.b.venn_enabled = true
					vim.cmd [[setlocal ve=all]]
					-- Draw a line on HJKL keystrokes
					vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
					vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
					-- Draw a box by pressing "f" with visual selection
					vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
				else
					vim.cmd [[setlocal ve=]]
					vim.cmd [[mapclear <buffer>]]
					vim.b.venn_enabled = nil
				end
			end
			vim.api.nvim_set_keymap('n', '<leader>v', "<cmd>lua Toggle_venn()<CR>", { noremap = true })
		end
	},
	
	-- ========================================================================
	-- Quick Scope - Character highlighting for f/F/t/T motions
	-- ========================================================================
	"unblevable/quick-scope",
}
