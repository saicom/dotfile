local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip.loaders.from_vscode").lazy_load()
local compare = require("cmp.config.compare")
local types = require("cmp.types")

-- 下面会用到这个函数
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmpFormat = function(entry, vim_item)
	-- fancy icons and a name of kind
	vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
	-- set a name for each source
	vim_item.menu = ({
		buffer = "[Buffer]",
		ultisnips = "[UltiSnips]",
		nvim_lsp = "[LSP]",
		nvim_lua = "[Lua]",
		cmp_tabnine = "[TabNine]",
		look = "[Look]",
		path = "[Path]",
		spell = "[Spell]",
		calc = "[Calc]",
		emoji = "[Emoji]",
	})[entry.source.name]
	return vim_item
end

cmp.setup({
	formatting = {
		format = cmpFormat,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(), -- 取消补全，esc也可以退出
		["<CR>"] = cmp.mapping.confirm({ select = true }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),

	-- 这里重要
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "path" },
		{ name = "look" },
		{ name = "spell" },
	}),
	matching = {
		disallow_fuzzy_matching = true,
		disallow_fullfuzzy_matching = true,
		disallow_partial_fuzzy_matching = true,
		disallow_partial_matching = true,
		disallow_prefix_unmatching = true,
	},
	preselect = types.cmp.PreselectMode.None,
	sorting = {
		priority_weight = 2,
		comparators = {
			compare.exact,
			compare.recently_used,
			compare.order,
			compare.offset,
			compare.kind,
			-- compare.scopes,
			compare.score,
			compare.locality,
			-- compare.sort_text,
			compare.length,
		},
	},
})

--dap cmp

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- cmp.setup.cmdline('/', {
--     sources = {
--         { name = 'buffer' }
--     }
-- })

-- cmp.setup.cmdline(":", {
-- 	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
-- })
--
-- local lspkind = require("lspkind")

-- cmp.setup({
-- 	formatting = {
-- 		format = lspkind.cmp_format({
-- 			mode = "symbol", -- show only symbol annotations
-- 			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
-- 			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
--
-- 			-- The function below will be called before any actual modifications from lspkind
-- 			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
-- 			before = function(entry, vim_item)
-- 				return vim_item
-- 			end,
-- 		}),
-- 	},
-- })
