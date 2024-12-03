---@type NvPluginSpec
-- NOTE: Show Better Diagnostic Inline
return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000,   -- needs to be loaded in first
	config = function()
		require('tiny-inline-diagnostic').setup({
			preset = "powerline",
		})
	end
}
