require("dap-go").setup()

local dap_breakpoint_color = {
	breakpoint = {
		ctermbg = 0,
		fg = "#993939",
		bg = "#31353f",
	},
	logpoing = {
		ctermbg = 0,
		fg = "#61afef",
		bg = "#31353f",
	},
	stopped = {
		ctermbg = 0,
		fg = "#98c379",
		bg = "#31353f",
	},
}

vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

local dap_breakpoint = {
	error = {
		text = "",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	condition = {
		text = "ﳁ",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	rejected = {
		text = "",
		texthl = "DapBreakpint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	logpoint = {
		text = "",
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	},
	stopped = {
		text = "",
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

local dapui = require("dapui")
dapui.setup()

vim.keymap.set("n", "<F5>", ":lua require 'dap'.continue()<cr>")
vim.keymap.set("n", "<F8>", ":lua require 'dap'.step_over()<cr>")
vim.keymap.set("n", "<F7>", ":lua require 'dap'.step_into()<cr>")
vim.keymap.set("n", "<S-F8>", ":lua require 'dap'.step_out()<cr>")
vim.keymap.set("n", "<leader>b", ":lua require 'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>B", ":lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set(
	"n",
	"<leader>lp",
	":lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
)

vim.keymap.set({ "n" }, "<leader>p", ":lua require('dapui').eval()<cr>", { noremap = true, silent = true })
-- vim.keymap.set(
-- 	{ "n" },
-- 	"<leader>dfo",
-- 	":lua require('dapui').float_element('repl')<cr>",
-- 	{ noremap = true, silent = true }
-- )

local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dap.repl.open()
end

-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dap.repl.close()
-- end
--
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dap.repl.close()
-- end

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enable_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = false,
	filter_references_pattern = "<module",
	virt_text_pos = "eol",
	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
})
