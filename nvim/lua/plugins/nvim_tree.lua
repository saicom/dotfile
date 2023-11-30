local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	-- api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open Horizontal"))
	vim.keymap.set("n", "s", api.node.open.vertical, opts("Open Vertical"))
	vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("Change Root"))
	vim.keymap.set("n", "I", api.tree.toggle_hidden_filter, opts("Toggle Filter: Git Hidden"))
	vim.keymap.set("n", "H", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
	vim.keymap.set("n", "p", api.node.navigate.parent, opts("Parent Directory"))

	vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
	vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))

	vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "P", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))

	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
end

require("nvim-tree").setup({
	prefer_startup_root = true,
	sync_root_with_cwd = true,
	sort_by = "case_sensitive",
	on_attach = on_attach,
	hijack_cursor = true,
	filters = {
		git_ignored = false,
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_root = false,
		ignore_list = {},
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		show_on_open_dirs = true,
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				git = true,
				file = true,
				folder = true,
				folder_arrow = true,
			},
			glyphs = {
				folder = {
					arrow_closed = "⏵",
					arrow_open = "⏷",
				},
				git = {
					unstaged = "󰄱",
					staged = "",
					unmerged = "",
					renamed = "󰁕",
					untracked = "",
					deleted = "✖",
					ignored = "",
				},
			},
		},
	},
})
