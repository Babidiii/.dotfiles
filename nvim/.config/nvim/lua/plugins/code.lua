-- ============================================================================
-- Code-Specific Tools
-- Refactoring, code generation, language-specific helpers
-- ============================================================================

return {
	-- ========================================================================
	-- Tree-sitter Just (Justfile support)
	-- ========================================================================
	"IndianBoy42/tree-sitter-just",
	
	-- ========================================================================
	-- Rust: Rustaceanvim
	-- ========================================================================
	{
		'mrcjkb/rustaceanvim',
		version = '^6',
		lazy = false,
		ft = { 'rust' },
	},
	
	-- ========================================================================
	-- Rust: Crates.nvim - Cargo.toml helper
	-- ========================================================================
	{
		'saecki/crates.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		lazy = false,
		config = function()
			local function show_documentation()
				local filetype = vim.bo.filetype
				if vim.tbl_contains({ 'vim', 'help' }, filetype) then
					vim.cmd('h ' .. vim.fn.expand('<cword>'))
				elseif vim.tbl_contains({ 'man' }, filetype) then
					vim.cmd('Man ' .. vim.fn.expand('<cword>'))
				elseif vim.fn.expand('%:t') == 'Cargo.toml' and require('crates').popup_available() then
					require('crates').show_popup()
				else
					vim.lsp.buf.hover()
				end
			end
			vim.keymap.set('n', 'K', show_documentation, { noremap = true, silent = true })
			require('crates').setup()
		end,
		keys = {
			{
				"<leader>cf",
				function() require("crates").show_features_popup() end,
				desc = "Cargo Features popups"
			},
			{
				"<leader>cd",
				function() require("crates").open_documentation() end,
				desc = "Cargo Open documentation"
			}
		}
	},
	
	-- ========================================================================
	-- Helm Language Server
	-- ========================================================================
	{
		"qvalentin/helm-ls.nvim",
		ft = "helm",
		opts = {},
	},
	
	-- ========================================================================
	-- Mini.nvim - Surround text objects
	-- ========================================================================
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
			require("mini.surround").setup({})
		end
	},
	
	-- ========================================================================
	-- Marks - Enhanced marks visualization
	-- ========================================================================
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
	
	-- ========================================================================
	-- Neogen - Generate annotations/documentation
	-- ========================================================================
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},
	
	-- ========================================================================
	-- Inc-Rename - Incremental LSP rename with preview
	-- ========================================================================
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
	
	-- ========================================================================
	-- Refactoring - Extract functions, variables, etc.
	-- ========================================================================
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},
}
