" ----------------------------------------------------------------------------
"  - Default Settings
" ----------------------------------------------------------------------------
set path+=**
set wildmenu
filetype indent plugin on
syntax on
set nocompatible
set nowrap
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set smartcase
set scrolloff=8
set hidden
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nohlsearch
set colorcolumn=90
set number relativenumber
set signcolumn=yes
set termguicolors
set guicursor=

" ----------------------------------------------------------------------------
"  - Languages
" ----------------------------------------------------------------------------
" set spelllang=en,fr
" set encoding=utf8

" ----------------------------------------------------------------------------
"  - Plugins 
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
""" Documentation
" Markdown
" Plug 'vim-pandoc/vim-rmarkdown'               " markdown R for vim
" Plug 'vim-pandoc/vim-pandoc'                  " pandoc
" Plug 'vim-pandoc/vim-pandoc-syntax'           " pandoc syntax
" Latex
" Plug 'lervag/vimtex'
" Vimwiki
Plug 'vimwiki/vimwiki'

""" Interface
Plug 'vim-airline/vim-airline'           " Vim airline status
Plug 'vim-airline/vim-airline-themes'   " Vim airline status themes
Plug 'flazz/vim-colorschemes'            

""" Language
Plug 'fatih/vim-go'  " Golang feature
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'

""" LSP Configuration
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

""" Utils
Plug 'tpope/vim-surround'      " parentheses,brackets...
Plug 'tpope/vim-commentary' 
Plug 'tpope/vim-fugitive'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'mbbill/undotree'
Plug 'unblevable/quick-scope'
Plug 'junegunn/vim-easy-align'

""" File sharing
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/popup.nvim'

" Fun
Plug 'mhinz/vim-startify'
Plug 'junegunn/goyo.vim'
Plug 'vuciv/vim-bujo'
call plug#end()

lua require'colorizer'.setup()

" ----------------------------------------------------------------------------
"  - ColorScheme
" ----------------------------------------------------------------------------
set background=dark
colorscheme gruvbox             " Set the colorscheme to OceanicNext
" let g:airline_theme='bubblegum' " Set the airline status bar to bubblegum theme
let g:airline_theme='apprentice' " Set the airline status bar to bubblegum theme

" ColorColumnColor
highlight ColorColumn guibg=#FF7986

" ----------------------------------------------------------------------------
"  - Remap
" ----------------------------------------------------------------------------
let mapleader=" "

" Disable retard mapping
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>

" Resizing window
nmap <C-h> :vertical resize -4<CR>
nmap <C-l> :vertical resize +4<CR>
nmap <C-k> :resize +4<CR>
nmap <C-j> :resize -4<CR>


" Deletion remap
vnoremap <leader>p "_dP
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG


nnoremap <leader>u :UndotreeShow<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
" " Autoclose
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O




" selection 
nnoremap Y y$

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" undo break points
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u

" ctrl o and ctrl i flow from k and j jump 
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" moving block cursor in any mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==i
inoremap <C-k> <esc>:m .-2<CR>==i
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==


" -----------------------------------------------------------------------------
"     - Human error correction -
" -----------------------------------------------------------------------------
:command! W w

" Rust
let g:rustfmt_autosave = 1
" let g:rustfmt_fail_silently = 1

" ----------------------------------------------------------------------------
"  - Fugitive
" ----------------------------------------------------------------------------
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" ----------------------------------------------------------------------------
"  - Terminal
" ----------------------------------------------------------------------------
tnoremap <Esc> <C-\><C-n>

" Terminal mode:
tnoremap <M-h> <c-\><c-n><c-w>h
tnoremap <M-j> <c-\><c-n><c-w>j
tnoremap <M-k> <c-\><c-n><c-w>k
tnoremap <M-l> <c-\><c-n><c-w>l





" ----------------------------------------------------------------------------
"  - Fugitive
" ----------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
"  - dmenu buffer/tab file finder
"  Source link http://leafo.net/posts/using_dmenu_to_open_quickly.html
" ----------------------------------------------------------------------------
" Strip the newline from the end of a string
function! Chomp(str)
	return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
	"let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
	let fname = Chomp(system("find . |  dmenu -i -l 20 -p " . a:cmd))
	if empty(fname)
		return
	endif
	execute a:cmd . " " . fname
endfunction

" map <c-t> :call DmenuOpen("tabe")<cr> " tab a new file from dmenu
" map <c-f> :call DmenuOpen("e")<cr>    " open a new file 

" ----------------------------------------------------------------------------
"  - VimTex Config
" ----------------------------------------------------------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
set conceallevel=1
let g:vimwiki_text_ignore_newline=0   "Newlines in a list item are converted to <br />s.

" ----------------------------------------------------------------------------
"  - Telescope
" ----------------------------------------------------------------------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope loclist<cr>
nnoremap <leader>fc <cmd>Telescope quickfix<cr>
nnoremap <leader>fu <cmd>Telescope git_files<cr>

" ----------------------------------------------------------------------------
"  - Startify
" ----------------------------------------------------------------------------
let g:startify_lists = [                                                                             
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'bookmarks',  'header': ['    Bookmarks:'] },                                       
  \ ]     
let g:startify_files_number        = 10
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_update_oldfiles     = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim' },
        \ ]

let g:ascii = [
            \'   ██████╗  █████╗ ██████╗ ██╗██████╗ ██╗██╗██╗',
            \'   ██╔══██╗██╔══██╗██╔══██╗██║██╔══██╗██║██║██║',
            \'   ██████╔╝███████║██████╔╝██║██║  ██║██║██║██║',
            \'   ██╔══██╗██╔══██║██╔══██╗██║██║  ██║██║██║██║',
            \'   ██████╔╝██║  ██║██████╔╝██║██████╔╝██║██║██║',
            \'   ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═════╝ ╚═╝╚═╝╚═╝',
            \]
        " \ startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')
let g:startify_custom_header = g:ascii + startify#fortune#boxed()

let g:startify_custom_footer =
       \ ['', "   https://github.com/Babidiii", '']




" ----------------------------------------------------------------------------
"  - Bujo TODO 
" ----------------------------------------------------------------------------
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" ----------------------------------------------------------------------------
"  - QuickScope
" ----------------------------------------------------------------------------
nmap <leader>q <plug>(QuickScopeToggle)
xmap <leader>q <plug>(QuickScopeToggle)
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
let g:qs_hi_priority = 2
let g:qs_enable=1       " Start disable
let g:qs_max_chars=100   " Disable on long line

" ----------------------------------------------------------------------------
"  - LSP  
" ----------------------------------------------------------------------------
lua << EOF

local lspconfig = require'lspconfig'
--- lspconfig.gopls.setup{
---   root_dir = lspconfig.util.root_pattern('.git');
--- }

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

EOF


" ----------------------------------------------------------------------------
"  - Autocompletion
" ----------------------------------------------------------------------------
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]
set shortmess+=c



