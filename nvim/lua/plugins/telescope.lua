if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

local trouble = require("trouble.providers.telescope")

local z_utils = require("telescope._extensions.zoxide.utils")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- IMPORTANT
				-- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
				["<C-h>"] = R("telescope").extensions.hop.hop, -- hop.hop_toggle_selection
				["<C-t>"] = trouble.open_with_trouble, -- open with trouble
			},
			n = {
				["<C-t>"] = trouble.open_with_trouble, -- open with trouble
			},
		},
	},
	extensions = {
		zoxide = {
			prompt_title = "[ Walking on the shoulders of TJ ]",
			mappings = {
				default = {
					after_action = function(selection)
						print("Update to (" .. selection.z_score .. ") " .. selection.path)
					end,
				},
				["<C-s>"] = {
					before_action = function(selection)
						print("before C-s")
					end,
					action = function(selection)
						vim.cmd.edit(selection.path)
					end,
				},
				-- Opens the selected entry in a new split
				["<C-q>"] = { action = z_utils.create_basic_command("split") },
			},
		},
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
require("telescope").load_extension("fzf")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("luasnip")
-- require("telescope").load_extension("projects")

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
