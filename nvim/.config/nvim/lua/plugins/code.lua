return {
  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
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

  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- Refactoring tool
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

  -- Go forward/backward with square brackets
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
	file = { suffix = "" },
	window = { suffix = "" },
	quickfix = { suffix = "" },
	yank = { suffix = "" },
	treesitter = { suffix = "n" },
      })
    end,
  },
  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" } },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" } },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, remap = true },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, remap = true },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
	-- default augends used when no group name is specified
	default = {
	  augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
	  augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
	  augend.constant.alias.bool, -- boolean value (true <-> false)
	  augend.date.alias["%Y/%m/%d"], -- date (2022/02/18, etc.)
	  augend.date.alias["%m/%d/%Y"], -- date (02/19/2022)
	  augend.date.new({
	    pattern = "%m.%d.%Y",
	    default_kind = "day",
	    only_valid = true,
	    word = false,
	  }),
	  augend.misc.alias.markdown_header,
	},
      })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },

  {
    'doums/rg.nvim',
    cmd = { 'Rg', 'Rgf', 'Rgp', 'Rgfp' },
  }

}
