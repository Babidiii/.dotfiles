-- ------------------------------------------------------------------------
-- Lsp
-- ------------------------------------------------------------------------

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local bufnr_map=vim.api.nvim_buf_set_keymap
local on_attach =function(_, bufrn)
  local opts = { noremap = true, silent = true }
  bufnr_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  bufnr_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  bufnr_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  bufnr_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  bufnr_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  bufnr_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- bufnr_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	bufnr_map(bufnr, 'n', 'ca','<cmd>Telescope lsp_code_actions<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  bufnr_map(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  bufnr_map(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  bufnr_map(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  bufnr_map(bufnr, 'n', '<leader>vf','<cmd>lua vim.lsp.buf.formatting()<CR>',opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  -- Diagnostic
  -- bufnr_map(bufnr, n','<leader>ve','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = "rounded" })<CR>',opts)
  -- bufnr_map(bufnr, n','<leader>vn','<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',opts)
  -- bufnr_map(bufnr, n','<leader>vp','<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',opts)
  -- bufnr_map(bufnr, n','<leader>vq','<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',opts)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'gopls', 'pyright', 'tsserver', 'vuels' }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach= on_attach,
    capabilities = capabilities,
  }
end


require('lspconfig').rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workdir = vim.fn.getcwd()
local volume = workdir..":"..workdir..":z"

require'lspconfig'.jdtls.setup{
  cmd = {
    'podman', 
    'run', '--rm', '--interactive', 
    '--name', 'jdt_nvim_container',
    '--volume='..volume,
    'localhost/jdt_lsp_container', 
    'java', 
    '-Declipse.application=org.eclipse.jdt.ls.core.id1', 
    '-Dosgi.bundles.defaultStartLevel=4', 
    '-Declipse.product=org.eclipse.jdt.ls.core.product', 
    '-Dlog.protocol=true', 
    '-Dlog.level=ALL', '-Xms1g', 
    '-jar', '/app/jdt_lsp/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar', 
    '-configuration', '/app/jdt_lsp/config_linux/', 
    '-data', vim.fn.expand('/app/jdtls-workspace/') .. workspace_dir,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  },
  -- root_dir = require('lspconfig').util.root_pattern(".git", vim.fn.getcwd()),
  capabilities = capabilities,
  on_attach = on_attach,
}


-- 'java',
-- '-Declipse.application=org.eclipse.jdt.ls.core.id1',
-- '-Dosgi.bundles.defaultStartLevel=4',
-- '-Declipse.product=org.eclipse.jdt.ls.core.product',
-- '-Dlog.protocol=true',
-- '-Dlog.level=ALL',
-- '-Xms1g',
-- '-jar', 'path_to_jdtls_install/plugins/org.eclipse.equinox_launcher...',
-- '-configuration', '/path/to/jdtls_install_location/config_linux/',
-- '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,

-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = lspcontainers.command('html', {
-- 	image = "lspcontainers/html-language-server:1.4.0",
-- 	cmd = function (runtime, volume, image)
--       return {
--         runtime,
--         "container",
--         "run",
--         "--interactive",
--         "--rm",
--         "--volume",
--         volume,
--         image
--       }
--     end,
--   }),
--   root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
-- }

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'




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
local cmp = require 'cmp'
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
    { name = 'nvim_lsp' },
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


--- https://github.com/lukas-reineke/dotfiles/blob/8465f0075bf3a2d9a69b68249ed7d3d6f9346e13/vim/lua/lsp.lua#L269-L308
--- https://github.com/mattn/efm-langserver
--- local prettier = require "efm/prettier"
