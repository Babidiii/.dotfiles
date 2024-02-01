return {
  -- LSP & Snippets
  "arkav/lualine-lsp-progress",
  -- Collection of configurations for built-in LSP client
  "neovim/nvim-lspconfig",
  {
    "jose-elias-alvarez/null-ls.nvim",
--     dependencies = {
--       {
-- 	"jay-babu/mason-null-ls.nvim",
-- 	cmd = { "NullLsInstall", "NullLsUninstall" },
-- 	opts = { handlers = {} },
--       },
--     },
--     opts = function() return { on_attach = require("astronvim.utils.lsp").on_attach } end,
  },
  -- {
  --   "stevearc/aerial.nvim",
  --   opts = {
  --     attach_mode = "global",
  --     backends = { "lsp", "treesitter", "markdown", "man" },
  --     disable_max_lines = vim.g.max_file.lines,
  --     disable_max_size = vim.g.max_file.size,
  --     layout = { min_width = 28 },
  --     show_guides = true,
  --     filter_kind = false,
  --     guides = {
	-- mid_item = "├ ",
	-- last_item = "└ ",
	-- nested_top = "│ ",
	-- whitespace = "  ",
  --     },
  --     keymaps = {
	-- ["[y"] = "actions.prev",
	-- ["]y"] = "actions.next",
	-- ["[Y"] = "actions.prev_up",
	-- ["]Y"] = "actions.next_up",
	-- ["{"] = false,
	-- ["}"] = false,
	-- ["[["] = false,
	-- ["]]"] = false,
  --     },
  --   },
  -- },
  -- Autocompletion plugin
  -- LSP source for nvim-cmp
  "hrsh7th/cmp-nvim-lsp",
  -- Snippets source for nvim-cmp
  "hrsh7th/nvim-cmp",

  "saadparwaiz1/cmp_luasnip",
  -- Snippets plugin
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  {
    'weilbith/nvim-code-action-menu',
    cmd = 'CodeActionMenu',
  },
}
