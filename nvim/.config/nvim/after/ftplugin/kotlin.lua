
local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
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
  bufnr_map(bufnr, 'n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
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


local workdir = vim.fn.getcwd()
local volume = workdir..":"..workdir..":z"

require'lspconfig'.kotlin_language_server.setup{
  cmd = {
    'podman',
    'run', '--rm', '--interactive',
    '--volume='..volume,
    'localhost/kt_lsp_container',
    '/app/kotlin-language-server/server/build/install/server/bin/kotlin-language-server'
  },
  -- root_dir = root_pattern("settings.gradle"),
  capabilities = capabilities,
  on_attach = on_attach,
}
