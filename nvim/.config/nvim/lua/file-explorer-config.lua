local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'
local history = require("lir.history")
local get_context = require("lir.vim").get_context

local _actions = {}

local function home()
  vim.cmd('edit ' .. vim.fn.expand('$HOME'))
end

-- Go down the tree
function _actions.down()
  local par_dir, old, path
  local ctx = get_context()
  local cur = ctx:current_value()
  if not cur then
    return
  end

  path = string.gsub(ctx.dir, "/$", "")
  name = vim.fn.fnamemodify(path, ":t")
  par_dir = vim.fn.fnamemodify(ctx.dir, ":p:h:h")

  history.add(par_dir, name)

  -- if directory then go down
  if vim.fn.isdirectory(ctx.dir .. cur) == 1 then
    vim.cmd("keepalt edit " .. ctx.dir .. cur)
    return
  end
  -- else edit
  actions.edit()
end

local function goto_git_root()
  local dir = require('lspconfig.util').find_git_ancestor(vim.fn.getcwd())
  if dir == nil or dir == "" then
    return
  end
  vim.cmd ('e ' .. dir)
end


require'lir'.setup {
  show_hidden_files = true,
  devicons_enable = true,
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

    -- -- You can define a function that returns a table to be passed as the third
    -- -- argument of nvim_open_win().
    -- win_opts = function()
    --   local width = math.floor(vim.o.columns * 0.8)
    --   local height = math.floor(vim.o.lines * 0.8)
    --   return {
    --     border = require("lir.float.helper").make_border_opts({
    --       "+", "─", "+", "│", "+", "─", "+", "│",
    --     }, "Normal"),
    --     width = width,
    --     height = height,
    --     row = 1,
    --     col = math.floor((vim.o.columns - width) / 2),
    --   }
    -- end,
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

-- custom folder icon
require'nvim-web-devicons'.set_icon({
  lir_folder_icon = {
    icon = "",
    color = "#ce6a84",
    name = "LirFolderNode"
  }
})

