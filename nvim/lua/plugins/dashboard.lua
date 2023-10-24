local status, db = pcall(require, "dashboard")
if not status then
	vim.notify("没有找到 dashboard")
	return
end

db.setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		project = {
			enable = true,
		},
		shortcut = {
			{
				desc = "󰊳 init.lua",
				group = "@property",
				action = "edit ~/AppData/Local/nvim/init.lua",
				key = "e",
			},
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "NewFile",
				group = "Label",
				action = "enew",
				key = "f",
			},
			{
				desc = " Projects",
				group = "DiagnosticHint",
				action = "Telescope project",
				key = "p",
			},
			{
				desc = " Oldfiles",
				group = "Number",
				action = "Telescope oldfiles",
				key = "o",
			},
		},
	},
})
