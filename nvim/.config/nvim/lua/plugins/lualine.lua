return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function() 
    local config = require('lualine').get_config()
    config.extensions = {'trouble', 'fugitive'}
    config.sections.lualine_c = {config.sections.lualine_c, 'lsp_progress'}
    require('lualine').setup(config)
  end
}
