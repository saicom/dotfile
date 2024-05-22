require("nvim-treesitter.configs").setup({
	-- 添加不同语言
	ensure_installed = {
		"vim",
		"bash",
		"c",
		"cpp",
		"json",
		"lua",
		"python",
		"go",
		"typescript",
		"tsx",
		"css",
		"rust",
		"yaml",
		"gdscript",
		"godot_resource",
	}, -- one of "all" or a list of languages
	ignore_install = { "javascript" },

	highlight = { enable = true, disable = { "javascript" } },
	indent = { enable = false },

	-- 不同括号颜色区分
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})
