-- telescope
require('telescope').setup({
  extensions = {
    project = {
      base_dirs = {
        {path = "~/Desktop/project"},
      },
      hidden_files = false, -- default: false
      themes = "dropdown"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
})

-- require("telescope").load_extension("file_browser")
-- require('telescope').load_extension('project')
-- require("telescope").load_extension("ui-select")

-- local M = {}

-- M.project_files = function()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require"telescope.builtin".git_files, opts)
--   if not ok then require"telescope.builtin".find_files(opts) end
-- end

-- return M
