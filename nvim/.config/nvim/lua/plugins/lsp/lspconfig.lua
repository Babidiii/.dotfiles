return {
  "arkav/lualine-lsp-progress",
  "jose-elias-alvarez/null-ls.nvim",
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { "antosha417/nvim-lsp-file-operations", config = true },
      -- -- Useful status updates for LSP
      -- -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
      {
	'weilbith/nvim-code-action-menu',
	cmd = 'CodeActionMenu',
      },
      {
	"hrsh7th/nvim-cmp",
	dependencies = { "hrsh7th/cmp-emoji" },
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
	  -- table.insert(opts.sources, { name = "emoji" })
	end,
      },
    },
    config =function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
	  if desc then
	    desc = 'LSP: ' .. desc
	  end

	  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
	end

	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', vim.lsp.buf.references,'[G]oto [R]eferences')
	nmap('gi', vim.lsp.buf.implementation,'[G]oto [I]mplementation')

	-- :help K
	nmap('K', vim.lsp.buf.hover,'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help,'Signature Documentation')

	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder,'[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder,'[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
	  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	nmap('<leader>t', vim.lsp.buf.type_definition,'[T]ype definition')
	nmap('<leader>rn', vim.lsp.buf.rename,'[R]e[N]ame')
	nmap('<leader>ca', CodeActionMenu, '[C]ode [A]ction')
	nmap('<leader>e', vim.diagnostic.open_float,'[E]rror Diagnostic')
	nmap('[d', vim.diagnostic.goto_prev,'Goto prev')
	nmap(']d', vim.diagnostic.goto_next,'Goto next')
	nmap('<leader>q', vim.diagnostic.setloclist,'')
	nmap('<leader>so', require('telescope.builtin').lsp_document_symbols, '')
	nmap('<leader>vf',vim.lsp.buf.formatting,'')

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', 
	  function(_) vim.lsp.buf.format() end, 
	  { desc = 'Format current buffer with LSP' })
      end


      -- Change the Diagnostic symbols in the sign column 
      -- local signs = { Error = "🦀", Warn = "🦍 ", Hint = "🍌", Info = "🦧" }
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

      for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	local hll = "DiagnosticLineNr" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hll })
      end



      local servers = {
	tsserver = {
	  -- root_dir = function(...)
	  --   return require("lspconfig.util").root_pattern(".git")(...)
	  -- end,
	  -- single_file_support = false,
	},
	cssls = {},
	tailwindcss = {
	  -- root_dir = function(...)
	  --   return require("lspconfig.util").root_pattern(".git")(...)
	  -- end,
	},
	rust_analyzer = {},
	lua_ls = {
	  Lua = {
	    workspace = { checkThirdParty = false },
	    telemetry = { enable = false },
	    hint = { enable = true, setType = true },
	    codelens = { enable = false },
	  },
	},
      }

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
	automaitc_installtion = true
      }

      mason_lspconfig.setup_handlers {
	function(server_name)
	  require('lspconfig')[server_name].setup {
	    capabilities = capabilities,
	    on_attach = on_attach,
	    settings = servers[server_name],
	    filetypes = (servers[server_name] or {}).filetypes,
	  }
	end
      }

      local border = {
	{"╭", "FloatBorder"},
	{"─", "FloatBorder"},
	{"╮", "FloatBorder"},
	{"│", "FloatBorder"},
	{"╯", "FloatBorder"},
	{"─", "FloatBorder"},
	{"╰", "FloatBorder"},
	{"│", "FloatBorder"},
      }

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end



      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      require('luasnip.loaders.from_snipmate').lazy_load({paths = snipmate})

      cmp.setup {
	snippet = {
	  expand = function(args)
	    luasnip.lsp_expand(args.body)
	  end,
	},
	window = {
	  -- completion = { border = border },
	  -- documentation = { border = border },
	  completion = {
	    -- border = border('CmpBorder'),
	    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│', },
	    -- winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
	    col_offset = -1,
	  },
	  documentation = {
	    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│', },
	  },
	  hover = {
	    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│', },
	  },
	},

	completion = {
	  -- completeopt = 'menu,menuone,noinsert',
	  completeopt = 'menu,menuone,noselect',
	},
	mapping = cmp.mapping.preset.insert {
	  ['<C-n>'] = cmp.mapping.select_next_item(),
	  ['<C-p>'] = cmp.mapping.select_prev_item(),
	  ['<C-d>'] = cmp.mapping.scroll_docs(-4),
	  ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  ['<C-Space>'] = cmp.mapping.complete {},
	  -- ['<CR>'] = cmp.mapping.confirm {
	  -- 	behavior = cmp.ConfirmBehavior.Replace,
	  -- 	select = true,
	  ['<C-CR>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = true,
	  },
	  ['<C-@>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = true,
	  },
	  ['<Tab>'] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	      cmp.select_next_item()
	    elseif luasnip.expand_or_locally_jumpable() then
	      luasnip.expand_or_jump()
	    else
	      fallback()
	    end
	  end, { 'i', 's' }),
	  ['<S-Tab>'] = cmp.mapping(function(fallback)
	    if cmp.visible() then
	      cmp.select_prev_item()
	    elseif luasnip.locally_jumpable(-1) then
	      luasnip.jump(-1)
	    else
	      fallback()
	    end
	  end, { 'i', 's' }),
	  ['<m-e>'] = cmp.mapping(function(fallback)
	    if luasnip.expand_or_locally_jumpable() then
	      luasnip.expand_or_jump()
	    else
	      fallback()
	    end
	  end, { 'i' }),
	  ['<m-E>'] = cmp.mapping(function(fallback)
	    if luasnip.locally_jumpable(-1) then 
	      luasnip.jump(-1)
	    else
	      fallback()
	    end
	  end, { 'i' }),
	},
	sources = cmp.config.sources({
	  { name = 'path', keyword_length = 1 },          -- file paths
	  { name = 'nvim_lsp', keyword_length = 1 },      -- from language server
	  { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
	  { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
	  -- { name = 'buffer', keyword_length = 2 },     -- source current buffer
	  { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
	  { name = 'calc'},                               -- source for math calculation
	  { name = 'crates', keyword_length = 2 },
	  { name = 'luasnip' },
	  { name = 'orgmode' },
	}, {
	  { name = 'buffer' },
	}),
	formatting = {
	  format = lspkind.cmp_format({
	    -- mode = 'symbol', -- show only symbol annotations
	    mode = 'symbol_text', -- show only symbol annotations
	    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
	    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

	    -- The function below will be called before any actual modifications from lspkind
	    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
	    before = function (entry, vim_item)
	      vim_item.menu = ({
		buffer = "[Buffer]",
		nvim_lsp = "[LSP]",
		luasnip = "[LuaSnip]",
		nvim_lua = "[Lua]",
		latex_symbols = "[LaTeX]",
	      })[entry.source.name]
	      vim_item.dup = ({
		path = 0,
		nvim_lsp = 0,
		nvim_lsp_signature_help = 0,
		nvim_lua = 0,
		buffer = 0,
		vsnip = 0,
		calc = 0,
		crates = 0,
	      })[entry.source.name] or 0


	      return vim_item
	    end
	  }),
	},
      }

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
	sources = {
	  { name = 'buffer' }
	}
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
	  { name = 'path' }
	}, {
	  { name = 'cmdline' }
	})
      })

      vim.diagnostic.config({
	virtual_text = {
	  prefix = '■', -- Could be '●', '▎', 'x'
	}
      })
    end
  }
}

