require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
		go = { "goimports", "gofumpt" },
		yaml = { "yamlfmt" },
		yml = { "yamlfmt" },
		vue = { "prettierd", "prettier" },
		json = { "deno_fmt" },

		cpp = { "clang_format" },
		cs = { "clang_format" },
		-- ["_"] = { "trim_whitespace" },
	},
	format_after_save = {
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local excluded_extensions = { "" }
		local file_extension = vim.fn.expand("%:e")

		for _, ext in ipairs(excluded_extensions) do
			if file_extension == ext then
				return -- 如果文件扩展名匹配，则返回，不执行格式化
			end
		end
		require("conform").format({ bufnr = args.buf })
	end,
})
