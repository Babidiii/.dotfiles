--- vimwiki
vim.g.vimwiki_list = {
  {
    path = '~/babidi-wiki/',
    syntax = 'markdown',
    ext = '.md'
  }
}
vim.g.vimwiki_ext2syntax = {
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown',
}
