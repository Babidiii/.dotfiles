-- ============================================================================
-- LSP Server Configurations
-- Language server settings and rustaceanvim setup
-- ============================================================================

local M = {}

-- ============================================================================
-- Get all server configurations
-- ============================================================================

function M.get_configs()
	return {
		-- ts_ls = {
		-- 	filetypes={
		-- 		'javascript',
		-- 		'javascriptreact',
		-- 		'typescript',
		-- 		'typescriptreact',
		-- 		'typescript.tsx',
		-- 	}
		-- },
		-- ====================================================================
		-- Systems Programming
		-- ====================================================================
		clangd = {},
		asm_lsp = {},
		
		-- ====================================================================
		-- Web Development
		-- ====================================================================
		cssls = {},
		tailwindcss = {
			init_options = {
				userLanguages = {
					elixir = 'phoenix-heex',
					eruby = 'erb',
					heex = 'phoenix-heex',
					svelte = 'html',
					rust = 'html',
				},
			},
			filetypes = {
				'css',
				"postcss",
				"sass",
				"scss",
				'html',
				'heex',
				'elixir',
				'eruby',
				'javascript',
				'javascriptreact',
				'typescript',
				'typescriptreact',
				'typescript.tsx',
				'svelte',
			},
		},
		
		-- ====================================================================
		-- Python
		-- ====================================================================
		pyright = {
			capabilities = (function()
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
				return capabilities
			end)(),
			disableOrganizeImports = true, -- Using Ruff
			python = {
				analysis = {
					ignore = { '*' }, -- Using Ruff
				},
			},
		},
		ruff = {},
		
		-- ====================================================================
		-- Configuration Files
		-- ====================================================================
		taplo = {}, -- TOML
		helm_ls = {
			settings = {
				['helm-ls'] = {
					yamlls = {
						path = "yaml-language-server",
					}
				}
			}
		},
		
		-- ====================================================================
		-- Lua
		-- ====================================================================
		lua_ls = {
			Lua = {
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				hint = { enable = true, setType = true },
				codelens = { enable = false },
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim', 'require' },
				},
				telemetry = { enable = false },
			},
		},
		
		-- NOTE: rust_analyzer is NOT in this list
		-- It's managed by rustaceanvim (see setup_rustaceanvim below)
	}
end

-- ============================================================================
-- Setup rustaceanvim configuration
-- Handles Rust LSP and DAP (debugging) setup
-- ============================================================================

function M.setup_rustaceanvim(on_attach)
	local fn = vim.fn
	local osname = vim.loop.os_uname().sysname
	
	-- Construct paths relative to the Mason root
	local mason_root = fn.getenv("MASON") or fn.stdpath("data") .. "/mason"
	local codelldb = mason_root .. "/bin/codelldb"
	local lib = mason_root .. "/share/codelldb/extension/lldb/lib/liblldb"
	
	-- Set library extension based on OS
	if osname == "Darwin" then
		lib = lib .. ".dylib"
	else
		lib = lib .. ".so"
	end
	
	-- Configure rustaceanvim globally
	vim.g.rustaceanvim = {
		-- DAP (Debug Adapter Protocol) configuration
		dap = {
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, lib),
		},
		
		-- LSP server configuration
		server = {
			on_attach = function(client, bufnr)
				require("notify")("LSP " .. client.name .. " attached")
				on_attach(client, bufnr)
			end,
			
			-- rust-analyzer settings
			default_settings = {
				["rust-analyzer"] = {
					-- Cargo configuration
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = { enable = true },
					},
					
					-- Check on save with clippy
					checkOnSave = {
						enable = true,
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
					
					-- Procedural macro support
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = nil,
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					
					-- Inlay hints
					inlayHints = {
						lifetimeElisionHints = {
							enable = true,
							useParameterNames = true
						},
					},
				},
			},
		},
	}
end

return M
