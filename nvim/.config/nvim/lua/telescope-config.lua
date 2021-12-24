-- telescope
require('telescope').load_extension('project')
require('telescope').setup({
  extensions = {
    project = {
      base_dirs = {
        '~/Desktop/project',
      },
      hidden_files = false -- default: false
    }
  }
})

-- local M = {}

-- M.project_files = function()
--   local opts = {} -- define here if you want to define something
--   local ok = pcall(require"telescope.builtin".git_files, opts)
--   if not ok then require"telescope.builtin".find_files(opts) end
-- end

-- return M
