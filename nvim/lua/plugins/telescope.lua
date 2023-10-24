if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

-- local trouble = require("trouble.providers.telescope")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- IMPORTANT
				-- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
				["<C-h>"] = R("telescope").extensions.hop.hop, -- hop.hop_toggle_selection
				-- ["<C-t>"] = trouble.open_with_trouble, -- open with trouble
			},
			n = {
				-- ["<C-t>"] = trouble.open_with_trouble, -- open with trouble
			},
		},
	},
	extensions = {
		hop = {
			-- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
			keys = {
				"a",
				"s",
				"d",
				"f",
				"g",
				"h",
				"j",
				"k",
				"l",
				";",
				"q",
				"w",
				"e",
				"r",
				"t",
				"y",
				"u",
				"i",
				"o",
				"p",
				"A",
				"S",
				"D",
				"F",
				"G",
				"H",
				"J",
				"K",
				"L",
				":",
				"Q",
				"W",
				"E",
				"R",
				"T",
				"Y",
				"U",
				"I",
				"O",
				"P",
			},
			-- Highlight groups to link to signs and lines; the below configuration refers to demo
			-- sign_hl typically only defines foreground to possibly be combined with line_hl
			sign_hl = { "WarningMsg", "Title" },
			-- optional, typically a table of two highlight groups that are alternated between
			line_hl = { "CursorLine", "Normal" },
			-- options specific to `hop_loop`
			-- true temporarily disables Telescope selection highlighting
			clear_selection_hl = false,
			-- highlight hopped to entry with telescope selection highlight
			-- note: mutually exclusive with `clear_selection_hl`
			trace_entry = true,
			-- jump to entry where hoop loop was started from
			reset_selection = true,
		},
	},
})

require("telescope").load_extension("project")
require("telescope").load_extension("hop")
require("telescope").load_extension("dap")
require("telescope").load_extension("telemake")

vim.api.nvim_set_keymap(
	"n",
	"<A-o>",
	":lua require'telescope'.extensions.project.project{}<CR>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"i",
	"<A-c>",
	"<C-O>:lua require('telescope._extensions.project.actions').add_project_cwd()<CR>",
	{ noremap = true, silent = true }
)
