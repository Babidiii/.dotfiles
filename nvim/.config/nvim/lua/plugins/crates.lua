return {
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
}
