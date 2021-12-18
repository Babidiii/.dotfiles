local lspconfig = require'lspconfig'
lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
    
lspconfig.tsserver.setup{
    on_attach = function(client)
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" };
        cmd = { "typescript-language-server", "--stdio" };
        root_dir = root_pattern("package.json");                                                                               
        client.resolved_capabilities.document_formatting = true
        on_attach(client)
    end
}

lspconfig.pyright.setup{}

--- https://github.com/lukas-reineke/dotfiles/blob/8465f0075bf3a2d9a69b68249ed7d3d6f9346e13/vim/lua/lsp.lua#L269-L308
--- https://github.com/mattn/efm-langserver
--- local prettier = require "efm/prettier"
