vim.o.timeout = true
vim.o.timeoutlen = 300
local wk = require("which-key")

function open_var()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.scopes).open()
end
function open_expr()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.expression)
end

local mappings = {
	c = { ":bdelete<cr>", "Close Tab" },
	v = { "<C-w>v", "Vertical Split" },
	h = { "<C-w>s", "Horizontal Split" },
	s = { ":cd %:p:h<cr>", "Change To Current Directory" },
	t = {
		name = "ToggleTerm",
		f = { "<cmd>ToggleTerm direction=float<cr>", "New Terminal" },
		g = { "<cmd>lua _LAZYGIT_TOGGLE() <cr>", "New Lazygit Terminal" },
	},
	d = {
		name = "Debugging",
		c = { "<cmd>lua require'telescope'.extensions.dap.commands()<cr>", "Commands" },
		C = { "<cmd>lua require'telescope'.extensions.dap.configurations()<cr>", "Configurations" },
		-- v = { "<cmd>lua require'telescope'.extensions.dap.variables()<cr>", "Variables" },
		f = { "<cmd>lua require'telescope'.extensions.dap.frames()<cr>", "Frames" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		r = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear All Breakpoints" },
		t = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
		v = { "<cmd>lua open_var()<cr>", "Variables" },
		p = { "<cmd>lua open_expr()<cr>", "Open expr" },
	},
	f = {
		name = "Telescope",
		f = { "<cmd>Telescope find_files<cr>", "Find Files" },
		g = { "<cmd>Telescope live_grep<cr>", "Find Content" },
		b = { "<cmd>Telescope buffers<cr>", "Find In Buffer" },
		h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
		r = { "<cmd>Telescope resume<cr>", "Resume" },
		H = { "<cmd>Telescope search_history<cr>", "History" },
		s = { "<cmd>Telescope grep_string<cr>", "Find String" },
		R = { "<cmd>Telescope lsp_references<cr>", "List References" },
		i = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
		d = { "<cmd>Telescope lsp_definitions<cr>", "Go To Definitions" },
		D = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
		o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
		c = { "<cmd>Telescope command_history<cr>", "Command History" },
		m = { "<cmd>Telescope telemake<cr>", "Makefile" },
	},
	g = {
		name = "Git",
		c = { "<cmd>Telescope git_commits<cr>", "List Commits" },
		B = { "<cmd>Telescope git_bcommits<cr>", "List Buffer commits" },
		s = { "<cmd>Telescope git_status<cr>", "Git Status" },
		S = { "<cmd>Telescope git_stash<cr>", "Git Stash" },
		b = { "<cmd>Telescope git_branches<cr>", "Git Branch" },
	},
	l = {
		name = "LSP",
		i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
		d = { "<cmd>Lspsaga goto_definition <cr>", "Go To Definition" },
		p = { "<cmd>Lspsaga peek_definition<cr>", "Peek Definition" },
		-- r = {"<cmd>lua vim.lsp.buf.references()<cr>", "References"},
		r = { "<cmd>Telescope lsp_references<cr>", "References" },
		-- R = {"<cmd>lua vim.lsp.buf.rename()<cr>", "Rename"},
		R = { "<cmd>Lspsaga rename ++project<cr>", "Rename" },
		c = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
		o = { "<cmd>Lspsaga outline<cr>", "Code Outline" },
	},
	-- trouble list diagnostics
	x = {
		name = "Trouble",
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Worksapce Diagnostics" },
		d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
	},
}
local opt = {
	prefix = "<leader>",
	mode = "n",
}

wk.register(mappings, opt)
