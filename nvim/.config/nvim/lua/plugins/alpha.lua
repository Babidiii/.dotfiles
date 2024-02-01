-- ------------------------------------------------------------------------
-- Alpha plugin
-- links: https://github.com/goolord/alpha-nvim
-- ------------------------------------------------------------------------

return { 
  "goolord/alpha-nvim",
  dependencies = { 
    "kyazdani42/nvim-web-devicons" 
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    require("alpha.term")

    -- local width = 40
    -- local height = 24 -- two pixels per vertical space
    -- dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .. "/temp_dotfiles/art/yoshi.sh"
    -- dashboard.section.terminal.width = width
    -- dashboard.section.terminal.height = height
    -- dashboard.section.terminal.opts.redraw = true

    function on_big_screen()
      return vim.o.columns > 150 and vim.o.lines >= 40
    end


    dashboard.config.opts.noautocmd = false

    local header = {
      "                                              ",
      " ██████╗  █████╗ ██████╗ ██╗██████╗ ██╗██╗██╗ ",
      " ██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗██║██║██║ ",
      " ██████╔╝███████║██████╔╝██║██║  ██║██║██║██║ ",
      " ██╔══██╗██╔══██║██╔══██╗██║██║  ██║██║██║██║ ",
      " ██████╔╝██║  ██║██████╔╝██║██████╔╝██║██║██║ ",
      " ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═════╝ ╚═╝╚═╝╚═╝ ",
      "                                        NVIM  ",
    }

    local footers = {{
      "⠄⠄⠄⠄⠄⠄⠄⠄⢀⢀⣴⣿⣿⣷⣶⣤⣄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⢀⣤⡶⠿⢘⣥⠢⠐⠗⣹⣿⣿⣿⣤⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⠘⣅⣂⠹⣪⣭⣥⣶⣿⡿⠿⢭⡻⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⢀⣤⣤⡀⠄⣭⣧⣾⡿⠿⡋⢅⡪⠅⣢⣿⡿⠟⢁⣶⣶⣶⣤⣠⣄⡀⠄⠄",
      "⢠⣴⣿⣿⣟⣤⣤⡉⠭⣑⡨⢔⣊⣵⣶⡿⠛⢉⣴⡾⠿⠿⣿⣿⣿⣎⠻⣿⣦⡀",
      "⣼⣧⢻⣿⣿⣿⡈⣿⢰⢰⠌⣻⣭⣭⣶⡷⣠⡤⠶⠾⠛⢓⣒⣮⣝⡻⠸⣼⣿⣿",
      "⣿⣝⢶⣿⣿⣿⡃⠄⢏⣸⡄⢻⡿⣿⣟⣵⠶⢛⣛⣛⣛⡒⠦⣝⠿⣿⣦⡙⣿⡿",
      "⠻⣿⣿⣿⣿⣿⣷⣦⣜⡿⣿⣄⢓⡘⠃⣴⣾⣿⣿⣿⣿⢹⣯⣶⣅⢺⣿⡇⠻⠁",
      "⠄⠈⠛⠻⣿⣿⣿⣿⣿⣿⣿⡾⣿⣷⣾⣝⣻⢿⣿⣿⣿⠸⣛⣿⡟⣢⢻⣿⠄⠄",
      "⠄⠄⠄⠄⠘⢿⣿⣿⣿⣿⣿⣷⣦⣭⣿⣿⣿⣦⣵⡾⢃⣾⣿⣿⢱⡿⣸⠋⠄⠄",
      "⠄⠄⠄⠄⠄⠄⢻⣿⢿⣿⣿⠻⣿⣿⡿⠿⣟⣛⣉⣰⣿⣿⣿⠇⠛⠃⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⠄⠄⠉⠲⣝⣫⣓⡙⣿⣜⣛⣛⣛⣻⡯⠹⠛⠁⠄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠙⠛⢻⡈⢿⡿⠟⠛⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
    }, {
      "⠄⣾⠟⢋⣉⣙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄",
      "⣶⠏⣰⣿⣿⣿⣿⣶⣌⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠄",
      "⣿⣴⠟⣋⣩⣭⣭⣿⣿⣶⣾⣿⣿⣿⣿⣿⣿⡿⠟⢛⣉⣉⣉⡙⠻⣿⣿⣿⣿⡄",
      "⣿⢁⣾⣿⣿⣿⣯⣛⠛⣿⣿⣿⣿⣿⣿⣿⣯⣤⡾⣿⣿⣿⣿⣿⣷⣤⠉⠻⣿⣷",
      "⣿⠘⠋⠉⠉⣉⣉⣉⡙⠻⢿⣿⣿⣿⣿⣿⣿⠏⣴⣾⣥⣶⣶⣤⣍⣻⣿⣿⣿⣿",
      "⣿⠘⠁⠄⠄⢸⣿⣿⣿⡷⠂⣹⣿⣿⣿⣿⣿⠘⠛⠛⠛⠻⣿⣿⣿⣿⣿⣿⠛⣿",
      "⣿⡄⠄⣀⣀⣚⣛⣉⣥⡴⠾⠿⢻⣿⣿⣿⣿⡇⢀⡋⠄⠄⣀⠉⠛⠿⢿⠟⣸⣿",
      "⣿⣿⣄⠛⠿⠟⢻⣿⣡⣴⡶⠄⣾⣿⣿⣿⣿⣿⣌⡙⠿⣶⣶⣶⣶⣶⣶⣶⣿⣿",
      "⣿⣿⣿⣿⡿⠟⢋⣽⣿⠟⣠⣿⣿⣿⣿⣿⣿⡿⣿⣿⣶⣦⣶⣿⣿⣮⣭⣶⣿⣿",
      "⣿⡿⠏⣁⣀⢔⠿⠋⡏⢸⣿⣿⣿⡿⠛⠉⠉⣰⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      "⣿⣶⠞⣉⣁⣉⣁⣈⡀⠘⠛⠛⠉⣤⣚⣛⣙⣋⣻⣇⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      "⣿⠁⣼⡟⠻⠿⠿⠿⣿⣿⣦⣤⣄⣀⣉⣉⣉⣉⡛⢻⣀⣿⣿⢻⣿⣿⣿⣿⣿⣿",
      "⣿⣦⡈⠻⢷⣤⣙⠒⠶⢤⣭⣭⣭⣭⠍⢉⣩⣾⡿⠈⣿⣿⣿⣦⣽⣿⣿⣿⣿⣿",
      "⣿⣿⣿⣦⣤⣈⡛⠻⠿⠶⠶⠶⠶⠶⠚⣛⣉⣠⣴⣾⣿⣿⠿⢛⣿⣿⣿⣿⣿⣿",
      "⢿⠟⣽⢿⣿⣿⣿⠻⠶⡶⢶⠲⣶⣿⣿⣿⣿⣿⣿⡟⢿⣷⣶⣿⣿⣿⣿⣿⠟⠋",
    }, {
      "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠰⢾⣶⣦⢀⣀⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⣀⡀⢿⣿⡆⣿⣿⣿⣦⡀⠄⣀⣀⡀⠄⠄⠄⠄",
      "⠄⠄⣰⣶⣄⠄⠄⠄⠄⠄⡾⠁⣀⠙⠸⣿⡇⡟⣋⣩⣴⣶⣶⣶⣍⢿⣷⣄⠄⠄",
      "⠄⠄⠈⠙⠻⢷⡄⠄⠄⢠⣝⡀⠤⣴⣧⣭⠄⡞⠛⠻⣭⣭⣭⡛⢿⢸⣿⣿⡆⠄",
      "⠄⠄⠄⠄⠄⠄⠑⠄⠄⠄⠙⠻⣿⣶⣶⣶⢸⠄⠒⠄⢸⣿⣿⣷⡌⡼⣿⣿⣧⠄",
      "⣴⣿⣿⣿⣿⣷⣶⣤⣀⢠⣴⡾⢟⡻⢿⣿⣷⢄⣐⠶⠿⠿⠛⣛⣃⣴⣿⣿⡿⠄",
      "⣿⠿⠛⠉⠉⢉⣉⡉⢭⣥⣿⣧⡘⣿⣮⣻⣿⣶⣮⣭⣍⣋⣭⣭⣴⣿⣿⣟⣱⣿",
      "⠄⠄⠄⢀⣴⣿⠟⠄⠘⣿⡿⢛⣣⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
      "⠄⠄⠄⠘⠻⠋⠄⠄⠄⠘⢇⣛⣛⣛⣩⣽⣿⣿⣿⣿⣿⣿⠋⣿⣿⣿⣿⣿⣿⣿",
      "⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⡿⢏⣾⣿⣿⣿⣿⣿⣿⣿",
      "⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⣤⣶⣶⣝⠻⢿⣿⣿⣿⣷⣶⣿⣿⣿⣿⣿⣿⣿⣿⠿",
      "⠄⠄⠄⠄⠄⠄⢀⣤⣾⣿⣿⣿⣿⣿⣿⣶⣬⣝⣛⡛⠿⠿⠿⠿⠿⢟⣛⣩⣤⣄",
    },{
      "⠄⠄⠄⠄⠄⠄⠄⣠⣴⣶⣿⣿⡿⠶⠄⠄⠄⠄⠐⠒⠒⠲⠶⢄⠄⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⠄⣠⣾⡿⠟⠋⠁⠄⢀⣀⡀⠤⣦⢰⣤⣶⢶⣤⣤⣈⣆⠄⠄⠄⠄⠄",
      "⠄⠄⠄⠄⢰⠟⠁⠄⢀⣤⣶⣿⡿⠿⣿⣿⣊⡘⠲⣶⣷⣶⠶⠶⠶⠦⠤⡀⠄⠄",
      "⠄⠔⠊⠁⠁⠄⠄⢾⡿⣟⡯⣖⠯⠽⠿⠛⠛⠭⠽⠊⣲⣬⠽⠟⠛⠛⠭⢵⣂⠄",
      "⡎⠄⠄⠄⠄⠄⠄⠄⢙⡷⠋⣴⡆⠄⠐⠂⢸⣿⣿⡶⢱⣶⡇⠄⠐⠂⢹⣷⣶⠆",
      "⡇⠄⠄⠄⠄⣀⣀⡀⠄⣿⡓⠮⣅⣀⣀⣐⣈⣭⠤⢖⣮⣭⣥⣀⣤⣤⣭⡵⠂⠄",
      "⣤⡀⢠⣾⣿⣿⣿⣿⣷⢻⣿⣿⣶⣶⡶⢖⣢⣴⣿⣿⣟⣛⠿⠿⠟⣛⠉⠄⠄⠄",
      "⣿⡗⣼⣿⣿⣿⣿⡿⢋⡘⠿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠄⠄",
      "⣿⠱⢿⣿⣿⠿⢛⠰⣞⡛⠷⣬⣙⡛⠻⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⠿⠛⣓⡀⠄",
      "⢡⣾⣷⢠⣶⣿⣿⣷⣌⡛⠷⣦⣍⣛⠻⠿⢿⣶⣶⣶⣦⣤⣴⣶⡶⠾⠿⠟⠁⠄",
      "⣿⡟⣡⣿⣿⣿⣿⣿⣿⣿⣷⣦⣭⣙⡛⠓⠒⠶⠶⠶⠶⠶⠶⠶⠶⠿⠟⠄⠄⠄",
      "⠿⡐⢬⣛⡻⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡶⠟⠃⠄⠄⠄⠄⠄⠄",
      "⣾⣿⣷⣶⣭⣝⣒⣒⠶⠬⠭⠭⠭⠭⠭⠭⠭⣐⣒⣤⣄⡀⠄⠄⠄⠄⠄⠄⠄⠄",
      "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠄⠄⠄⠄⠄⠄⠄",
    }}

    dashboard.section.header.val = header
    dashboard.section.header.opts.hl = "String"

    -- math.randomseed(os.time())
    -- local random_dashboard_id = math.random(1, #(footers))
    -- dashboard.section.footer.val = footers[random_dashboard_id]
    -- dashboard.section.footer.opts.hl = "String"

    dashboard.section.buttons.val = {
      dashboard.button("e", "📝 New File", ":enew<CR>"),
      dashboard.button("f", "🔎 Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "⌛ Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("t", "📜 Find Text", ":Telescope live_grep<CR>"),
      dashboard.button("c", "⚙️ Config", ":edit ~/.config/nvim/init.lua<CR>"),
      dashboard.button("q", "❌ Quit", ":qa<CR>"),
    }

    -- table.insert(dashboard.section.footer.val, "")
    dashboard.section.footer.val= " - NVIM config by @Babidiii - "

    alpha.setup(dashboard.opts)

  end
}
