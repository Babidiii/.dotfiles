-- Status line
-- source provider function
local diagnostic = require('galaxyline.provider_diagnostic')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local extension = require('galaxyline.provider_extensions')
local colors = require('galaxyline.colors')
local buffer = require('galaxyline.provider_buffer')
local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')

-- -- provider 
-- BufferIcon  = buffer.get_buffer_type_icon,
-- BufferNumber = buffer.get_buffer_number,
-- FileTypeName = buffer.get_buffer_filetype,
-- -- Git Provider
-- GitBranch = vcs.get_git_branch,
-- DiffAdd = vcs.diff_add,             -- support vim-gitgutter vim-signify gitsigns
-- DiffModified = vcs.diff_modified,   -- support vim-gitgutter vim-signify gitsigns
-- DiffRemove = vcs.diff_remove,       -- support vim-gitgutter vim-signify gitsigns
-- -- File Provider
-- LineColumn = fileinfo.line_column,
-- FileFormat = fileinfo.get_file_format,
-- FileEncode = fileinfo.get_file_encode,
-- FileSize = fileinfo.get_file_size,
-- FileIcon = fileinfo.get_file_icon,
-- FileName = fileinfo.get_current_file_name,
-- LinePercent = fileinfo.current_line_percent,
-- ScrollBar = extension.scrollbar_instance,
-- VistaPlugin = extension.vista_nearest,
-- -- Whitespace
-- Whitespace = whitespace.get_item,
-- -- Diagnostic Provider
-- DiagnosticError = diagnostic.get_diagnostic_error,
-- DiagnosticWarn = diagnostic.get_diagnostic_warn,
-- DiagnosticHint = diagnostic.get_diagnostic_hint,
-- DiagnosticInfo = diagnostic.get_diagnostic_info,
-- -- LSP
-- GetLspClient = lspclient.get_lsp_client,

-- public libs

-- require('galaxyline.provider_fileinfo').get_file_icon_color -- get file icon color
-- -- custom file icon with color
-- local my_icons = require('galaxyline.provider_fileinfo').define_file_icon() -- get file icon color
-- my_icons['your file type here'] = { color code, icon}
-- -- if your filetype does is not defined in neovim  you can use file extensions
-- my_icons['your file ext  in here'] = { color code, icon}

-- -- built-in condition
-- local condition = require('galaxyline.condition')
-- condition.buffer_not_empty  -- if buffer not empty return true else false
-- condition.hide_in_width  -- if winwidth(0)/ 2 > 40 true else false
-- -- find git root, you can use this to check if the project is a git workspace
-- condition.check_git_workspace() 

-- -- built-in theme
-- local colors = require('galaxyline.theme').default

-- bg = '#202328',
-- fg = '#bbc2cf',
-- yellow = '#ECBE7B',
-- cyan = '#008080',
-- darkblue = '#081633',
-- green = '#98be65',
-- orange = '#FF8800',
-- violet = '#a9a1e1',
-- magenta = '#c678dd',
-- blue = '#51afef';
-- red = '#ec5f67';

local gl = require('galaxyline')
local colors = require('galaxyline.theme').default
local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = {'NvimTree','vista','dbui','packer'}

local M = {}
M.icons = {
	n      = " ",
	i      = " ",
	c      = "ﲵ ",
	V      = " ",
	[""] = " ",
	v      = " ",
	C      = "ﲵ ",
	R      = "﯒ ",
	t      = " ",
}

M.colors = {
	aqua   = "#89b482",
	blue   = "#7daea3",
	fg     = "#d4be98",
	gray   = "#928374",
	green  = "#89b482",
	orange = "#e78a4e",
	purple = "#d3869b",
	red    = "#ea6962",
	yellow = "#d8a657",
  bg     = "#32302F",
}

M.mode_color = {
	n      = M.colors.yellow,
	i      = M.colors.green,
	v      = M.colors.blue,
	[""] = M.colors.blue,
	V      = M.colors.blue,
	c      = M.colors.purple,
	no     = M.colors.red,
	s      = M.colors.orange,
	S      = M.colors.orange,
	[""] = M.colors.orange,
	ic     = M.colors.yellow,
	R      = M.colors.violet,
	Rv     = M.colors.violet,
	cv     = M.colors.red,
	ce     = M.colors.red,
	r      = M.colors.blue,
	rm     = M.colors.blue,
	["r?"] = M.colors.blue,
	["!"]  = M.colors.red,
	t      = M.colors.red,
}

local mode_color = {
  n      = colors.red,
  i      = colors.green,
  v      = colors.blue,
  [''] = colors.blue,
  V      = colors.blue,
  c      = colors.magenta,
  no     = colors.red,
  s      = colors.orange,
  S      = colors.orange,
  [''] = colors.orange,
  ic     = colors.yellow,
  R      = colors.violet,
  Rv     = colors.violet,
  cv     = colors.red,
  ce     = colors.red,
  r      = colors.cyan,
  rm     = colors.cyan,
  ['r?'] = colors.cyan,
  ['!']  = colors.red,
  t      = colors.red,
}


M.semi_circle = function(is_left)
	if is_left then
		return " "
	else
		return " "
	end
end

M.transparent_border = {
	provider = function()
		return "  "
	end,
}

M.left_border = {
	provider = function()
		return M.semi_circle(true)
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.right_border = {
	provider = function()
		return M.semi_circle(false)
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.space = {
	provider = function()
		return " "
	end,
	highlight = { M.colors.bg, M.colors.bg },
}

M.has_file_type = function()
	local f_type = vim.bo.filetype
	if not f_type or f_type == "" then
		return false
	end
	return true
end

M.buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end



M.insert_left = function(element)
	table.insert(gls.left, element)
end

M.insert_blank_line_at_left = function()
  M.insert_left({ Space = M.space })
end

M.insert_mid = function(element)
	table.insert(gls.mid, element)
end

M.insert_blank_line_at_mid = function()
	M.insert_mid({ Space = M.space })
end

M.insert_right = function(element)
	table.insert(gls.right, element)
end

M.insert_blank_line_at_right = function()
  M.insert_right({ Space = M.space })
end

M.checkwidth = function()
	local squeeze_width = vim.fn.winwidth(0) / 2
	if squeeze_width > 40 then
		return true
	end
	return false
end

-----------------------------------------------------------------

-- M.insert_left({
-- 	GitIcon = {
-- 		provider = function()
-- 			return "  "
-- 		end,
-- 		condition = require("galaxyline.provider_vcs").check_git_workspace,
-- 		highlight = { M.colors.orange, M.colors.bg },
-- 	},
-- })

-- M.insert_left({
-- 	GitBranch = {
-- 		provider = "GitBranch",
-- 		condition = require("galaxyline.provider_vcs").check_git_workspace,
-- 		highlight = { M.colors.blue, M.colors.bg, "bold" },
-- 	},
-- })


-- M.insert_blank_line_at_left()

-- M.insert_left({
-- 	DiffAdd = {
-- 		provider = "DiffAdd",
-- 		condition = M.checkwidth,
-- 		icon = "  ",
-- 		highlight = { M.colors.green, M.colors.bg },
-- 	},
-- })

-- M.insert_left({
-- 	DiffModified = {
-- 		provider = "DiffModified",
-- 		condition = M.checkwidth,
-- 		icon = "  ",
-- 		highlight = { M.colors.green, M.colors.bg },
-- 	},
-- })

-- M.insert_left({
-- 	DiffRemove = {
-- 		provider = "DiffRemove",
-- 		condition = M.checkwidth,
-- 		icon = "  ",
-- 		highlight = { M.colors.red, M.colors.bg },
-- 	},
-- })


-- M.insert_left({ Separa = M.transparent_border })


-- -- Information panel
-- M.insert_left({ Start = M.transparent_border })

-- M.insert_left({
-- 	FileIcon = {
-- 		provider = "FileIcon",
-- 		condition = M.buffer_not_empty,
-- 		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, M.colors.bg },
-- 	},
-- })

-- M.insert_left({
-- 	BufferType = {
-- 		provider = "FileTypeName",
-- 		condition = M.has_file_type,
-- 		highlight = { M.colors.fg, M.colors.bg },
-- 	},
-- })

-- M.insert_blank_line_at_left()

-- -- Lsp panel
-- M.insert_mid({ Start = M.transparent_border })

-- M.insert_blank_line_at_mid()

-- M.insert_mid({
-- 	DiagnosticError = {
-- 		provider = "DiagnosticError",
-- 		icon = "  ",
-- 		highlight = { M.colors.red, M.colors.bg },
-- 	},
-- })

-- M.insert_mid({
-- 	DiagnosticHint = {
-- 		provider = "DiagnosticHint",
-- 		icon = "  ",
-- 		highlight = { M.colors.green, M.colors.bg },
-- 	},
-- })

-- M.insert_mid({
-- 	DiagnosticWarn = {
-- 		provider = "DiagnosticWarn",
-- 		icon = "  ",
-- 		highlight = { M.colors.yellow, M.colors.bg },
-- 	},
-- })

-- M.insert_blank_line_at_mid()

-- M.insert_mid({ Start = M.transparent_border })


-- -- Last Panel (?)
-- M.insert_right({ Start = M.transparent_border })

-- M.insert_right({
-- 	LineInfo = {
-- 		provider = "LineColumn",
-- 		separator = "  ",
-- 		separator_highlight = { M.colors.green, M.colors.bg },
-- 		highlight = { M.colors.fg, M.colors.bg },
-- 	},
-- })

-- M.insert_right({
-- 	PerCent = {
-- 		provider = "LinePercent",
-- 		separator = "  ",
-- 		separator_highlight = { M.colors.blue, M.colors.bg },
-- 		highlight = { M.colors.blue, M.colors.bg, "bold" },
-- 	},
-- })

-- M.insert_blank_line_at_right()

-- M.insert_right({
-- 	Encode = {
-- 		provider = "FileEncode",
-- 		separator = "  ",
-- 		separator_highlight = { M.colors.blue, M.colors.bg },
-- 		highlight = { M.colors.blue, M.colors.bg, "bold" },
-- 	},
-- })

-- M.insert_blank_line_at_right()

-- M.insert_right({ Separa = M.transparent_border })



-----------------------------------------------------------------
M.insert_left( {
  RainbowRed = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.bg}
  },
})


M.insert_left( {
  ViMode = {
    icon = function()
			return M.icons[vim.fn.mode()]
		end,
    provider = function()
      -- auto change color according the vim mode
      vim.api.nvim_command('hi GalaxyViMode guifg='..M.mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = {colors.red,colors.bg,'bold'},
  },
})
M.insert_left( {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg}
  }
})
M.insert_left({
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
})

M.insert_left( {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta,colors.bg,'bold'}
  }
})

M.insert_left( {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg},
  },
})

M.insert_left( {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.fg,colors.bg,'bold'},
  }
})



M.insert_mid({
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' ',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
})


M.insert_mid({
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { M.colors.red, M.colors.bg },
	},
})

M.insert_mid({
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { M.colors.yellow, M.colors.bg },
	},
})

M.insert_mid({
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { M.colors.green, M.colors.bg },
	},
})

M.insert_mid( {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
})


M.insert_right({
  FileEncode = {
    provider = 'FileEncode',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
})

M.insert_right({
  FileFormat = {
    provider = 'FileFormat',
    condition = condition.hide_in_width,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.green,colors.bg,'bold'}
  }
})

M.insert_right({
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
})

M.insert_right({
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
  }
})

M.insert_right({
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
})
M.insert_right({
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg},
  }
})
M.insert_right({
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
})

M.insert_right({
  RainbowBlue = {
    provider = function() return ' ▊' end,
    highlight = {colors.blue,colors.bg}
  },
})

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
}

gls.short_line_left[2] = {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg}
  }
}
