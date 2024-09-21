return {
  'rcarriga/nvim-notify',
  "lewis6991/impatient.nvim",
  -- Colorscheme
  {
    "Shatur/neovim-ayu",
    lazy = true
  },
  {
    "tiagovla/tokyodark.nvim",
    lazy = true
  },
  "rebelot/kanagawa.nvim",
  -- file explorer
  -- Summarizes issueu
  "folke/trouble.nvim",
  "kyazdani42/nvim-web-devicons",


  -- Treesitter
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- TPOPE comment features
  "tpope/vim-commentary",
  -- TPOPE git features
  "tpope/vim-fugitive",
  -- TPOPE github feature for gitfugitive
  "tpope/vim-rhubarb",
  -- use "tpope/vim-surround"

  -- Utils
  "mbbill/undotree",
  "unblevable/quick-scope",
  -- alt for vim-surround
  -- "machakann/vim-sandwich",
  "junegunn/vim-easy-align",
  "norcalli/nvim-colorizer.lua",
  "vimwiki/vimwiki",
  {"andymass/vim-matchup", event = "BufRead"}, -- extends vim's %,
  -- "vimwiki/vimwiki",
  -- take notes
  "vuciv/vim-bujo",
  -- silicon carbon.sh like feature
  "segeljakt/vim-silicon",
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opt=false,
    config = function()
      require("todo-comments").setup {
      }
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim"},
  },
  -- use "nvim-telescope/telescope-project.nvim" -- project telescope extension

  -- Other
  -- use "rcarriga/nvim-notify" -- notification manager
  -- highlight arguments
  { 'm-demare/hlargs.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { "yioneko/nvim-yati", dependencies = "nvim-treesitter/nvim-treesitter" },
  { "lewis6991/gitsigns.nvim", config = function()
      require("gitsigns").setup()
    end
  },
  -- Rust specific
  "simrat39/rust-tools.nvim",
  {
    'babidiii/rust-cfg.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'simrat39/rust-tools.nvim',
    },
    opt = false,
    config = function()
      require('telescope').load_extension('rust_cfg')
    end
  },

}
