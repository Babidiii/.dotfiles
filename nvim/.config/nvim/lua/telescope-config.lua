-- telescope
local actions = require "telescope.actions"

require('telescope').load_extension('project')
require('telescope').setup({
  pickers = {
    buffers = {
      mappings = {
	i = {
	  ["<M-d>"] = actions.delete_buffer + actions.move_to_top,
	}
      }
    },
  },
  extensions = {
    project = {
      base_dirs = {
	'~/projects',
      },
      hidden_files = false -- default: false
    }
  }
})

