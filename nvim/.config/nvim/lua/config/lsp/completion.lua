-- ============================================================================
-- Auto-completion Configuration (nvim-cmp)
-- Snippet expansion, sources, mappings, and formatting
-- ============================================================================

print("Loading completion module")
local M = {}

-- ============================================================================
-- Main setup function
-- ============================================================================

function M.setup()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local lspkind = require('lspkind')
	
	-- Load snippets from snipmate format
	require('luasnip.loaders.from_snipmate').lazy_load({ paths = snipmate })
	-- require('luasnip.loaders.from_vscode').lazy_load()
	
	-- Border style for completion windows
	local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
	
	cmp.setup({
		-- ================================================================
		-- Snippet Engine
		-- ================================================================
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		
		-- ================================================================
		-- Window Appearance
		-- ================================================================
		window = {
			completion = {
				border = border,
				col_offset = -1,
			},
			documentation = {
				border = border,
			},
		},
		
		-- ================================================================
		-- Completion Behavior
		-- ================================================================
		completion = {
			completeopt = 'menu,menuone,noselect',
		},
		
		-- ================================================================
		-- Key Mappings
		-- ================================================================
		mapping = cmp.mapping.preset.insert({
			-- Navigation
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			
			-- Scrolling documentation
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			
			-- Trigger completion manually
			['<C-Space>'] = cmp.mapping.complete({}),
			
			-- Confirm selection
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			['<C-CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			['<C-@>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			
			-- Tab completion with snippet jumping
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),
			
			-- Shift-Tab for reverse navigation
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
			
			-- Alt-e for snippet expansion/jump (alternative to Tab)
			['<m-e>'] = cmp.mapping(function(fallback)
				if luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i' }),
			
			-- Alt-Shift-E for reverse snippet jump
			['<m-E>'] = cmp.mapping(function(fallback)
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i' }),
		}),
		
		-- ================================================================
		-- Completion Sources
		-- ================================================================
		sources = cmp.config.sources({
			{ name = 'path', keyword_length = 1 },                 -- File paths
			{ name = 'nvim_lsp', keyword_length = 1 },             -- LSP completions
			{ name = 'nvim_lsp_signature_help' },                  -- Function signatures
			{ name = 'nvim_lua', keyword_length = 2 },             -- Neovim Lua API
			{ name = 'vsnip', keyword_length = 2 },                -- Vim snippets
			{ name = 'calc' },                                     -- Math calculations
			{ name = 'crates', keyword_length = 2 },               -- Rust crates
			{ name = 'luasnip' },                                  -- LuaSnip snippets
			{ name = 'orgmode' },                                  -- Orgmode completions
		}, {
			{ name = 'buffer' },                                   -- Buffer text (fallback)
		}),
		
		-- ================================================================
		-- Formatting
		-- ================================================================
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol_text',      -- Show both icon and text
				maxwidth = 50,             -- Max width of completion menu
				ellipsis_char = '...',     -- Truncation indicator
				
				-- Customize completion item appearance
				before = function(entry, vim_item)
					-- Set menu source labels
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
						path = "[Path]",
						calc = "[Calc]",
					})[entry.source.name]
					
					-- Prevent duplicate entries from certain sources
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
	})
	
	-- ====================================================================
	-- Command-line Completion
	-- ====================================================================
	
	-- Search mode (/)
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})
	
	-- Command mode (:)
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})
end

return M
