-- ============================================================================
-- Miscellaneous Utilities
-- General utilities and helper plugins
-- ============================================================================

return {
	-- ========================================================================
	-- Performance
	-- ========================================================================
	"lewis6991/impatient.nvim",
	
	-- ========================================================================
	-- Treesitter
	-- ========================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				yati = { enable = true },
				ensure_installed = { "lua", "rust", "toml", "markdown" },
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
				ident = { enable = true },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				}
			}
		end
	},
	"nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	{ "yioneko/nvim-yati", dependencies = "nvim-treesitter/nvim-treesitter" },
	
	-- ========================================================================
	-- Editing Utilities
	-- ========================================================================
	"tpope/vim-commentary",          -- Comment toggling
	{ "andymass/vim-matchup", event = "BufRead" }, -- Enhanced % matching
	"junegunn/vim-easy-align",       -- Text alignment
	
	-- ========================================================================
	-- Undo Tree
	-- ========================================================================
	"mbbill/undotree",
	
}
