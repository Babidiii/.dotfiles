-- ============================================================================
-- LSP Keymaps
-- Buffer-local keybindings for LSP functionality
-- ============================================================================

local M = {}

-- ============================================================================
-- Main on_attach function
-- Called when an LSP server attaches to a buffer
-- ============================================================================

function M.on_attach(client, bufnr)
	-- Helper function to create buffer-local normal mode keymaps
	local function nmap(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, { 
			buffer = bufnr, 
			desc = desc, 
			silent = true 
		})
	end
	
	-- Language-specific keybindings
	if client.name == "rust-analyzer" then
		M.setup_rust_keymaps(nmap)
	else
		M.setup_default_keymaps(nmap)
	end
	
	-- Common keybindings for all languages
	M.setup_common_keymaps(nmap)
	
	-- Create buffer-local format command
	vim.api.nvim_buf_create_user_command(bufnr, 'Format',
		function() vim.lsp.buf.format() end,
		{ desc = 'Format current buffer with LSP' })
end

-- ============================================================================
-- Rust-specific keybindings using rustaceanvim
-- ============================================================================

function M.setup_rust_keymaps(nmap)
	nmap("K", function() vim.cmd.RustLsp { 'hover', 'actions' } end, "Hover with Actions")
	nmap("J", function() vim.cmd.RustLsp('joinLines') end, "Join Lines")
	nmap("<leader>ca", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
	nmap("<leader>dr", function() vim.cmd.RustLsp("debuggables") end, "Debuggables")
	nmap("<leader>co", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
	nmap("<leader>em", function() vim.cmd.RustLsp("expandMacro") end, "Expand Macro")
	nmap("<leader>ch", function() vim.cmd.RustLsp { 'view', 'HIR' } end, "View HIR")
	nmap("<leader>cm", function() vim.cmd.RustLsp { 'view', 'MIR' } end, "View MIR")
end

-- ============================================================================
-- Default LSP keybindings for non-Rust languages
-- ============================================================================

function M.setup_default_keymaps(nmap)
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<leader>ca', '<cmd>CodeActionMenu<CR>', 'Code Action Menu')
end

-- ============================================================================
-- Common LSP keybindings for all languages
-- ============================================================================

function M.setup_common_keymaps(nmap)
	-- Navigation
	nmap('gD', function() vim.lsp.buf.declaration() end, 'Goto Declaration')
	nmap('gd', function() vim.lsp.buf.definition() end, 'Goto Definition')
	nmap('gr', vim.lsp.buf.references, 'Goto References')
	nmap('gi', vim.lsp.buf.implementation, 'Goto Implementation')
	nmap('<leader>t', vim.lsp.buf.type_definition, 'Type Definition')
	
	-- Code actions and refactoring
	nmap('<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
	nmap('<leader>vf', vim.lsp.buf.format, 'Format Buffer')
	
	-- Diagnostics
	nmap('<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
	nmap('<leader>dj', function() vim.diagnostic.goto_prev({ float = true }) end, 'Previous Diagnostic')
	nmap('<leader>dk', function() vim.diagnostic.goto_next({ float = true }) end, 'Next Diagnostic')
	nmap('<leader>q', function() vim.diagnostic.setloclist() end, 'Diagnostics to Location List')
	
	-- Workspace management
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, 'List Workspace Folders')
	
	-- Additional features
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
	nmap('<leader>o', '<cmd>Lspsaga outline<CR>', 'Toggle Outline')
	nmap('<leader>so', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
end

return M
