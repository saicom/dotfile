require("go").setup()
---@diagnostic disable Undefined
-- Run gofmt + goimport on save
--
function format_go()
	require("go.format").goimport()
end

-- local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.go",
--     callback = function()
--         require("go.format").goimport()
--         -- vim.cmd([[GoImport]])
--         -- 运行 goimports 命令
--
--         vim.defer_fn(function()
--             vim.cmd("noautocmd w")
--         end, 300)
--     end,
--     group = format_sync_grp,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.json",
	callback = function()
		vim.lsp.buf.format()
		vim.defer_fn(function()
			vim.cmd("noautocmd w")
		end, 100)
	end,
	group = format_sync_grp,
})

-- 获取当前光标处的结构体名
function get_cursor_struct_name()
	-- 获取光标所在行的文本
	local line = vim.fn.getline(".")
	-- 定义匹配 Go 结构体的正则表达式
	local pattern = "type%s+(%w+)%s+struct%s*{"

	-- 使用正则表达式匹配结构体名称
	local struct_name = string.match(line, pattern)

	if struct_name and struct_name ~= "" then
		print("结构体:" .. struct_name)
		return struct_name
	else
		print("未找到结构体")
		return ""
	end
end

-- 生成构造函数
function create_construct_func()
	local struct_name = get_cursor_struct_name()
	if struct_name == "" then
		print("创建失败，未找到结构体")
		return
	end

	--获取当前文件内容
	local currentBuffer = vim.api.nvim_get_current_buf()
	local fileContents = vim.api.nvim_buf_get_lines(currentBuffer, 0, -1, false)

	-- 构造函数的正则表达式模式
	local func_name = "New" .. struct_name

	-- 遍历文件内容，查找是否存在同名构造函数
	for _, line in ipairs(fileContents) do
		i = string.find(line, func_name)
		if i ~= nil then
			print("已经存在构造函数")
			return
		end
	end

	local construct_code = {
		"",
		string.format("func New%s() *%s {", struct_name, struct_name),
		string.format("    return &%s{}", struct_name),
		"}",
	}

	-- vim.fn.append(".", construct_code)
	-- 将构造函数内容追加到文档末尾
	vim.api.nvim_buf_set_lines(currentBuffer, -1, -1, false, construct_code)
end

function create_and_fill()
	create_construct_func()
	vim.api.nvim_feedkeys("G1k100l", "n", true)
	vim.defer_fn(function()
		vim.cmd([[GoFillStruct]])
	end, 100)
end

vim.cmd([[command! GoConstruct :lua create_and_fill()]])

local windows_nr = nil
local window_mappings = {}
local bufnr = nil

-- 定义一个函数来创建浮动窗口并显示选项
function showStructOptions()
	-- 获取当前光标所在行的文本
	local line = vim.fn.getline(".")
	local struct_name = get_cursor_struct_name()
	if struct_name == "" then
		vim.notify("Struct not found in current position")
		return
	end

	-- 使用正则表达式检查是否位于结构体定义行
	-- 如果在结构体定义行上，则创建浮动窗口
	-- 第一个 false - 创建一个空白缓冲区,不加载任何文件
	--第二个 false - 缓冲区不可见,不出现在缓冲区列表中
	bufnr = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(bufnr, "buftype", "nofile")
	vim.api.nvim_buf_set_option(bufnr, "filetype", "gostructpopup")

	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-o>", "<Nop>", { silent = true })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-i>", "<Nop>", { silent = true })

	local command = {
		"1. 创建构造函数",
		"2. 改名",
		"3. 实现接口",
	}

	-- 在浮动窗口中设置选项
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, command)

	-- 创建浮动窗口并显示
	local opts = {
		relative = "cursor",
		row = 1,
		col = 0,
		width = 50,
		height = #command,
		border = "single",
		style = "minimal",
		title = "Go Struct",
		title_pos = "center",
	}
	windows_nr = vim.api.nvim_open_win(bufnr, true, opts)

	-- 自定义 "Orange" 高亮组
	vim.api.nvim_set_hl(0, "GoOrange", { fg = "#ff8800" })
	vim.api.nvim_win_set_option(windows_nr, "winhighlight", "NormalFloat:NormalFloat,FloatBorder:GoOrange")

	vim.api.nvim_win_set_option(windows_nr, "number", false)
	vim.api.nvim_win_set_option(windows_nr, "relativenumber", false)
	vim.api.nvim_buf_set_option(bufnr, "readonly", true)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

	close_unfocus = vim.api.nvim_create_autocmd({ "WinLeave" }, {
		callback = function()
			closeFloatingWindow(windows_nr)
			if close_unfocus then
				vim.api.nvim_del_autocmd(close_unfocus)
				close_unfocus = nil
			end
		end,
	})

	-- 设置窗口相关的映射
	window_mappings[windows_nr] = {
		["q"] = function()
			closeFloatingWindow(windows_nr)
		end,
		["1"] = function()
			onEnter("1")
		end,
		["2"] = function()
			onEnter("2")
		end,
		["3"] = function()
			onEnter("3")
		end,
		-- 在这里添加其他映射
	}

	-- 为浮动窗口设置按键绑定
	local bufnr = vim.api.nvim_win_get_buf(windows_nr)
	local mappings = window_mappings[windows_nr]
	for key, func in pairs(mappings) do
		vim.api.nvim_buf_set_keymap(
			bufnr,
			"n",
			key,
			[[:lua invoke_function(']] .. key .. [[')<CR>]],
			{ noremap = true, silent = true }
		)
	end
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<CR>", [[:lua onEnter()<CR>]], { noremap = true, silent = true })
end

-- 定义一个函数来关闭浮动窗口并删除相关的映射
function closeFloatingWindow(winnr)
	if vim.api.nvim_win_is_valid(winnr) then
		vim.api.nvim_win_close(winnr, true)
	end
	window_mappings[winnr] = nil
end

-- 将函数映射到键盘快捷键
vim.api.nvim_set_keymap("n", "<F4>", ":lua showStructOptions()<CR>", { noremap = true, silent = true })

-- 在浮动窗口中执行按键绑定的操作
function invoke_function(key)
	local mappings = window_mappings[vim.fn.win_getid()]
	local func = mappings[key]
	if func then
		func()
	end
end

function onEnter(line)
	line = line or tostring(vim.fn.line("."))
	vim.notify(line)
	closeFloatingWindow(windows_nr)
	if line == "1" then
		create_and_fill()
	elseif line == "2" then
		vim.cmd([[GoRename]])
	elseif line == "3" then
		vim.cmd([[GoImpl]])
	end
end
