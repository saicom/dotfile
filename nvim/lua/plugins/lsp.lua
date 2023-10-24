require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	-- 确保安装，根据需要填写
	ensure_installed = {
		"lua_ls",
		"gopls",
		"bufls",
		"volar",
		"jsonls",
		"clangd",
		"cmake",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")

local util = require("lspconfig/util")

lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

local on_attach = function(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = "rounded",
		},
		hint_enable = true,
		hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
		shadow_guibg = "Yellow",
	}, bufnr)
end

lspconfig.volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = util.root_pattern(".git"),
	filetypes = { "vue", "yaml", "css", "markdown" },
})

lspconfig.jsonls.setup({
	capabilities = capabilities,
	filetypes = { "json" },
	single_file_support = true,
})

lspconfig.cmake.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	single_file_support = true,
})

lspconfig.bufls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "proto" },
	root_dir = util.root_pattern(".git"),
	init_options = {
		useDefaultBufLintConfig = true,
		useDefaultBufBreakingConfig = true,
		useDefaultBufBuildConfig = true,
	},
})

lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--background-index",
		"--log=verbose",
		"--query-driver=d:/MingW/*",
		"--pretty",
		"--background-index",
	},
	filetypes = { "c", "cpp", "cxx", "cc" },
	root_dir = util.root_pattern(".git"),
	settings = {
		["clangd"] = {
			["compilationDatabasePath"] = "build",
			["fallbackFlags"] = { "-std=c++17" },
		},
	},
})

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})
