return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      yati={enable=true },
      ensure_installed = { "lua", "rust", "toml", "markdown"},
      auto_install = true,
      highlight = {
	enable = true,
	additional_vim_regex_highlighting=true,
      },
      ident = { enable = true }, 
      rainbow = {
	enable = true,
	extended_mode = true,
	max_file_lines = nil,
      }
    }
  end
}
