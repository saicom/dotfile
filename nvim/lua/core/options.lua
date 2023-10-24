local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smarttab = true

opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")
opt.list = true

-- 保存
opt.autowrite = true
opt.swapfile = false

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
--opt.splitright = true
--opt.splitbelow = true

-- 字符集
opt.encoding = "utf-8"

-- 搜索
opt.ignorecase = true
opt.smartcase = true
vim.g.expand_region_text_objects = {
	iw = 0,
	iW = 0,
	['i"'] = 1,
	["i'"] = 1,
	["i]"] = 1,
	ib = 1,
	iB = 1,
	il = 1,
	ip = 1,
	ie = 0,
}

-- 外观
opt.termguicolors = true
opt.signcolumn = "yes"

vim.cmd([[colorscheme tokyonight-moon]])
vim.cmd([[highlight Visual cterm=bold gui=bold guifg=#1b1d2b guibg=#c3e88d]])
-- vim.cmd('autocmd VimEnter * NvimTreeOpen')
-- vim.cmd('autocmd VimEnter * NERDTree')
vim.cmd('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
-- vim.cmd [[let $shell = '/usr/bin/zsh']]
-- vim.cmd([[let &shellcmdflag = '-s']])

vim.cmd([[autocmd InsertLeave * :wa ]])
vim.cmd([[autocmd FocusGained,BufEnter * :checktime]])

vim.notify = require("notify")

local flashEnabled = false

function EnableFlash()
	local flash = require("flash")
	if not flashEnabled then
		-- vim.notify("flash enable")
		flash.treesitter_search()
	else
		flash.toggle()
	end
	flashEnabled = true
end

-- vim.cmd([[autocmd CmdlineEnter * require("flash").treesitter_search()]])
-- vim.api.nvim_create_user_command("EnableFlash", "lua EnableFlash()", {})
-- vim.cmd("autocmd BufEnter * EnableFlash")

-- vim.cmd("autocmd FileType javascript setlocal filetype=javascript")
-- vim.cmd("autocmd BufEnter * :cd %:p:h")

vim.cmd([[
augroup golang_indent_mapping
    autocmd!
    autocmd FileType go nnoremap <buffer> o o<Space><BS>
    autocmd FileType go nnoremap <buffer> O O<Space><BS>
    autocmd FileType go setlocal expandtab
augroup END
]])

-- window平台
if vim.fn.has("win32") == 1 then
	vim.o.shellcmdflag = "-s"
end
