return {
  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
	forward = true,
	multi_window = false,
	wrap = false,
	incremental = true,
      },
    },
  },
  
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
  },
  {
    "tamago324/lir.nvim",
    -- keys = {
    --   { "<leader>pv", "<cmd>lua require('lir.float').toggle()<cr>", desc="Lir"},
    -- },
    config = function()
      local actions           = require('lir.actions')
      local mark_actions      = require('lir.mark.actions')
      local clipboard_actions = require('lir.clipboard.actions')
      local history           = require("lir.history")
      local get_context       = require("lir.vim").get_context


      require'lir'.setup {
	show_hidden_files = true,
	devicons= {
	  enable = true,
	},
	mappings = {
	  ['e'] = actions.edit,
	  ['s'] = actions.split,
	  ['v'] = actions.vsplit,
	  ['t'] = actions.tabedit,
	  ['h'] = actions.up,
	  ['l'] = actions.edit,
	  ['<CR>'] = actions.edit,
	  ['q'] = actions.quit,
	  ['<esc>'] = actions.quit,
	  ['d'] = actions.mkdir,
	  ['%'] = actions.newfile,
	  ['R'] = actions.rename,
	  ['@'] = actions.cd,
	  ['Y'] = actions.yank_path,
	  ['.'] = actions.toggle_show_hidden,
	  ['D'] = actions.delete,
	  ['J'] = function()
	    mark_actions.toggle_mark()
	    vim.cmd('normal! j')
	  end,
	  ['C'] = clipboard_actions.copy,
	  ['X'] = clipboard_actions.cut,
	  ['P'] = clipboard_actions.paste,
	},
	float = {
	  winblend = 3,
	  curdir_window = {
	    enable = true,
	    highlight_dirname = true
	  },
	},
	hide_cursor = false,
	on_init = function()
	  -- use visual mode
	  vim.api.nvim_buf_set_keymap(
	    0,
	    "x",
	    "J",
	    ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
	    { noremap = true, silent = true }
	  )

	  -- echo cwd
	  vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
	end,
      }
    end
  }
}
