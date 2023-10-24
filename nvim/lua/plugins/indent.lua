vim.g.indent_blankline_char = "│"
vim.wo.colorcolumn = "99999"
-- vim.g.indent_blankline_char = "┊"

vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
	-- 'startify',
	"dashboard",
	-- 'dotooagenda',
	-- 'log',
	-- 'fugitive',
	-- 'gitcommit',
	-- 'packer',
	-- 'vimwiki',
	-- 'markdown',
	-- 'json',
	-- 'txt',
	-- 'vista',
	-- 'help',
	-- 'todoist',
	-- 'NvimTree',
	-- 'peekaboo',
	-- 'git',
	-- 'TelescopePrompt',
	-- 'undotree',
	-- 'flutterToolsOutline',
	"", -- for all buffers without a file type
}

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	"class",
	"function",
	"method",
	"block",
	"list_literal",
	"selector",
	"^if",
	"^table",
	"if_statement",
	"while",
	"for",
}

require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
})

-- because lazy load indent-blankline so need readd this autocmd
-- vim.cmd("autocmd CursorMoved * IndentBlanklineRefreshScroll")
--
-- require("mini.indentscope").setup({
-- 	symbol = "┆",
-- })
--
-- version 3
-- local highlight = {
-- 	"RainbowRed",
-- 	"RainbowYellow",
-- 	"RainbowBlue",
-- 	"RainbowOrange",
-- 	"RainbowGreen",
-- 	"RainbowViolet",
-- 	"RainbowCyan",
-- }
--
-- local hooks = require("ibl.hooks")
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
-- end)
-- require("ibl").setup({
-- 	indent = {
-- 		char = "┊",
-- 		tab_char = " ",
-- 		highlight = highlight,
-- 	},
-- 	exclude = {
-- 		filetypes = {
-- 			"dashboard",
-- 		},
-- 		buftypes = { "terminal", "nofile" },
-- 	},
-- 	whitespace = {
-- 		remove_blankline_trail = false,
-- 	},
-- 	scope = { highlight = highlight },
-- })
