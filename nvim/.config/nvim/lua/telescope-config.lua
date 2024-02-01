-- telescope
require('telescope').load_extension('project')
require('telescope').setup({
  extensions = {
    project = {
      base_dirs = {
        '~/projects',
      },
      hidden_files = false -- default: false
    }
  }
})

