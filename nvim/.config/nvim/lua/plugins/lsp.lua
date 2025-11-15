-- ============================================================================
-- LSP Plugin Specification
-- Single file that lazy.nvim loads, imports modules from config/lsp/
-- ============================================================================

-- Import module files (NOT plugin specs)
local keymaps = require('config.lsp.keymaps')
local servers = require('config.lsp.servers')
local completion = require('config.lsp.completion')

-- Return array of plugin specs for lazy.nvim
return {
	-- ========================================================================
	-- Mason - Package manager for LSP/DAP/linters/formatters
	-- ========================================================================
	{
		"williamboman/mason.nvim",
		keys = {
			{ "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
		},
		config = function()
			require("mason").setup({
				ensure_installed = {
					"codelldb", -- Rust debugger (DAP adapter)
				},
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	
	-- ========================================================================
	-- LSP Configuration
	-- ========================================================================
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			
			-- Lua development
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			
			-- Snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			
			-- Completion
			"hrsh7th/cmp-nvim-lsp",
			"onsails/lspkind.nvim",
			
			-- Code actions
			{
				"weilbith/nvim-code-action-menu",
				cmd = "CodeActionMenu",
			},
			
			-- nvim-cmp
			{
				"hrsh7th/nvim-cmp",
				dependencies = { "hrsh7th/cmp-emoji" },
			},
		},
		
		config = function()
			-- Setup completion first
			completion.setup()
			
			-- Get capabilities from nvim-cmp
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
			
			-- Setup Mason LSP config
			local mason_lspconfig = require('mason-lspconfig')
			local server_configs = servers.get_configs()
			
			mason_lspconfig.setup({
				-- Install all servers from the table
				ensure_installed = vim.tbl_keys(server_configs),
				
				-- Automatically install LSP servers
				automatic_installation = true,
				
				-- CRITICAL: Exclude rust_analyzer from automatic enabling
				-- This prevents mason-lspconfig from starting rust_analyzer
				-- since rustaceanvim handles it
				automatic_enable = {
					exclude = { "rust_analyzer" }
				},
				
				handlers = {
					-- Default handler for all LSP servers
					function(server_name)
						local opts = vim.tbl_extend("force", {
							capabilities = capabilities,
							on_attach = function(client, bufnr)
								keymaps.on_attach(client, bufnr)
								require("notify")("LSP " .. server_name .. " attached")
							end,
						}, server_configs[server_name] or {})
						
						-- Extract optional fields
						opts.filetypes = (server_configs[server_name] or {}).filetypes
						opts.root_dir = (server_configs[server_name] or {}).root_dir
						opts.init_options = (server_configs[server_name] or {}).init_options
						
						require("lspconfig")[server_name].setup(opts)
					end,
					
					-- Skip rust_analyzer - handled by rustaceanvim
					["rust_analyzer"] = function() end
				}
			})
			
			-- Setup rustaceanvim
			servers.setup_rustaceanvim(keymaps.on_attach)
		end
	},
	
	-- ========================================================================
	-- Null-ls (deprecated but might still be used)
	-- ========================================================================
	"jose-elias-alvarez/null-ls.nvim",
	
	-- ========================================================================
	-- Code Formatting & Linting
	-- ========================================================================
	{
		"stevearc/conform.nvim",
		event = "BufReadPost",
		opts = {
			-- Format on save with conditions
			format_after_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				
				-- Disable autoformat for files in certain paths
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname:match("/node_modules/") then
					return
				end
				
				-- Format with timeout and fallback to LSP if no formatter available
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
			
			-- Formatters organized by filetype
			formatters_by_ft = {
				-- Systems programming
				c = { "clang_format" },
				cpp = { "clang_format" },
				go = { "gofumpt" },
				
				-- Scripting
				lua = { "stylua" },
				
				-- Configuration files
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				
				-- Web development (all use prettier)
				css = { "prettier" },
				flow = { "prettier" },
				graphql = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				less = { "prettier" },
				markdown = { "prettier" },
				scss = { "prettier" },
				vue = { "prettier" },
			},
		},
	},
	
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPost",
		enabled = false, -- Set to true to enable linting
		config = function()
			-- Configure linters by filetype
			require("lint").linters_by_ft = {
				-- Examples (uncomment and install via Mason to use):
				-- python = { "flake8", "pylint" },
				-- javascript = { "eslint" },
			}
			
			-- Auto-run linters on cursor hold events
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	
	-- ========================================================================
	-- UI Enhancements
	-- ========================================================================
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{
				"<leader>lb",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Trouble | Buffer Diagnostics",
				silent = true
			},
			{
				"<leader>lw",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Trouble | Workspace Diagnostics",
				silent = true
			},
		},
		opts = {},
	},
	
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require('tiny-inline-diagnostic').setup({
				preset = "nonerdfont",
			})
		end
	},
	
	{
		'nvimdev/lspsaga.nvim',
		event = "LspAttach",
		config = function()
			require('lspsaga').setup({
				outline = {
					win_position = "right",
					show_detail = true,
					auto_preview = false,
					auto_refresh = true,
					auto_close = true,
					keys = {
						expand_or_collapse = "<Tab>",
						jump = "<CR>",
						quit = "q",
					},
				},
			})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		}
	},
	
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end
	},
	
	-- Setup UI customizations
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Setup diagnostic signs
			local signs = { 
				Error = "", 
				Warn = "", 
				Hint = "󰌵", 
				Info = "" 
			}
			
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { 
					text = icon, 
					texthl = hl, 
					numhl = hl 
				})
			end
			
			-- Setup borders
			local border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			}
			
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end
		end,
	},
}
