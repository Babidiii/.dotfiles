-- ------------------------------------------------------------------------
-- Lsp 
-- ------------------------------------------------------------------------

-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Diagnostic colors
vim.cmd [[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold
]]

-- DiagnosticSigns
local function lspSymbol(name, icon, hll)
  local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hll, texthl = hl })
end

lspSymbol("Error", "🦀", "DiagnosticLineNrError")
lspSymbol("Info",  "🦧", "DiagnosticLineNrInfo")
lspSymbol("Hint",  "🍌", "DiagnosticLineNrHint")
lspSymbol("Warn",  "🦍", "DiagnosticLineNrWarn")

-- ------------------------------------------------------------------------
-- Lsp config base
-- ------------------------------------------------------------------------

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local base_on_attach =function(client, bufrn)
  local map = vim.api.nvim_set_keymap 
  local opts = { noremap = true, silent = true }
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map('n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map('n', '<leader>ca', '<cmd>CodeActionMenu<CR>', opts)
  -- bp(bufnr, 'n', 'ca','<cmd>Telescope lsp_code_actions<CR>', opts)
  map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  map('n', '<leader>vf','<cmd>lua vim.lsp.buf.formatting()<CR>',opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- if client.server_capabilities.documentFormattingProvider then
  --   vim.lsp.buf.format { async = true }
  --   -- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  -- end
end

-- -----------------------------------------------------------------------------------
-- Rust specific
-- -----------------------------------------------------------------------------------

local on_attach_rust =function(client, bufrn)
 require('rust-tools').hover_actions.hover_actions()
  local map = vim.api.nvim_set_keymap 
  local opts = { noremap = true, silent = true }
  base_on_attach(client, bufrn)

  map('n', 'K', '<cmd>RustHoverAction<CR>', opts)
  map('n', '<leader>co','<cmd>RustOpenCargo<CR>',opts)
  map('n', '<leader>cc','<cmd>RustCodeAction<CR>',opts)
  map('n', '<leader>rr','<cmd>RustRunnables<CR>',opts)
  map('n', '<leader>rp','<cmd>RustParentModule<CR>',opts)
  map('n', '<leader>em','<cmd>RustExpandMacro<CR>',opts)
end

-- local opts = {
--   tools = { 
--     autoSetHints = true,
--     inlay_hints = {
--       show_parameter_hints = false,
--       other_hints_prefix = "",
--     },

--   },
--   server = {
--     standalone = false,	
--     on_attach = on_attach_rust,
--     settings = {
--       ["rust-analyzer"] = {
-- 	-- enable clippy on save
-- 	cargo = {
-- 	  features = {}
-- 	},
-- 	checkOnSave = {
-- 	  command = "clippy"
-- 	},
-- 	rustfmt = {
-- 	  overrideCommand = {"just", "fmt"}
-- 	},
-- 	completion = {
-- 	  privateEditable = {
-- 	    enable = true
-- 	  }
-- 	},
-- 	lens = {
-- 	  references = {
-- 	    adt = {
-- 	      enable = true
-- 	    },
-- 	    enumVariant = {
-- 	      enable = true
-- 	    },
-- 	    method = {
-- 	      enable = true
-- 	    },
-- 	    trait = {
-- 	      enable = true
-- 	    }
-- 	  }
-- 	},
-- 	references = {
-- 	  excludeImports = true
-- 	}
--       }
--     }
--   }
-- }

local opts = {
  tools = { -- rust-tools options
    autoSetHints = true,
      inlay_hints = {
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",
      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,
      -- whether to show variable name before type hints with the inlay hints or not
      -- default: false
      show_variable_name = false,
      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",
      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment",
    },
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach_rust,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
	cargo = {
	  features = nil,
	  noDefaultFeatures = true
	},
	checkOnSave = {
	  command = "clippy"
	},
	completion = {
	  privateEditable = {
	    enable = true
	  }
	},
	enable = true,
	enableExperimental = true,
        -- enable clippy on save
	disabled = {"unresolved-proc-macro"},
      }
    }
  },
}


require('rust-tools').setup(opts)

-- -----------------------------------------------------------------------------------
-- 
-- -----------------------------------------------------------------------------------

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

-- -----------------------------------------------------------------------------------
-- Other languages specific
-- -----------------------------------------------------------------------------------

-- -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'gopls', 'pyright', 'vuels' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach= on_attach,
--     capabilities = capabilities,
--   }
-- end

-- ------------------------------------------------------------------------
-- Snipets
-- ------------------------------------------------------------------------
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
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
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),

    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
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
  }, {
    { name = 'buffer' },
  })
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


--- https://github.com/lukas-reineke/dotfiles/blob/8465f0075bf3a2d9a69b68249ed7d3d6f9346e13/vim/lua/lsp.lua#L269-L308
--- https://github.com/mattn/efm-langserver
--- local prettier = require "efm/prettier"
