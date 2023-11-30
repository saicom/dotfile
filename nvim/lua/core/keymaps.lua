vim.g.mapleader = " "

local keymap = vim.keymap

-- 视觉模式
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- -- 窗口
-- keymap.set("n", "<leader>v", "<C-w>v") --水平新增窗口
-- keymap.set("n", "<leader>h", "<C-w>s") --垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>n", ":nohl<CR>", { silent = true, noremap = true })

-- 插件
keymap.set("n", "<F3>", ":NvimTreeToggle<CR>")
keymap.set("n", "ff", ":NvimTreeFocus<CR>")

-- keymap.set("n", "<F3>", ":NERDTreeToggle<CR>", { silent = true, noremap = true })
-- keymap.set("n", "ff", ":NERDTreeFind<CR>", { silent = true, noremap = true })

-- 切换buffer
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

keymap.set("n", "<F2>", "<cmd>lua EnableFlash()<cr>")

-- 在终端模式中按下 <Esc> 键退出
-- keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

keymap.set("v", "x", "d")

keymap.set("n", "<leader>q", ":copen<cr>", { noremap = true })

keymap.set("n", "<M-<>", ":vertical resize +5<cr>", { noremap = true })
keymap.set("n", "<M->>", ":vertical resize -2<cr>", { noremap = true })
keymap.set("n", "<M-1>", ":resize -2<cr>", { noremap = true, silent = true })
keymap.set("n", "<M-2>", ":resize +2<cr>", { noremap = true, silent = true })

function GoRun()
	vim.cmd(":execute 'GoRun'")
	vim.cmd([[copen]])
	vim.defer_fn(function()
		vim.api.nvim_feedkeys("G", "n", true)
	end, 1000)
end

keymap.set("n", "<F9>", ":lua GoRun()<cr>", { noremap = true })

keymap.set("n", "<leader>dir", ":echo expand('%:p:h')<cr>", { noremap = true })

-- 定义自定义函数
function SmoothScrollUp()
	vim.fn["smooth_scroll#up"](vim.o.scroll * 1, 10, 4)
end

function SmoothScrollDownf()
	vim.fn["smooth_scroll#down"](vim.o.scroll * 1, 10, 4)
end

-- 设置键映射
keymap.set("n", "<C-b>", ":lua SmoothScrollUp()<CR>", { noremap = true, silent = false })
keymap.set("n", "<C-f>", ":lua SmoothScrollDownf()<CR>", { noremap = true, silent = false })

-- function copy()
--     require('osc52').copy_register('+')
-- end
--
-- vim.api.nvim_create_autocmd('TextYankPost', { callback = copy })
