local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "folke/tokyonight.nvim",                        -- 主题
    "nvim-lualine/lualine.nvim",                    -- 状态栏
    -- "nvim-tree/nvim-tree.lua", -- 文档树
    { "nvim-tree/nvim-web-devicons", lazy = true }, -- 文档树图标

    -- "christoomey/vim-tmux-navigator", -- 用ctl-hjkl来定位窗口
    "nvim-treesitter/nvim-treesitter", -- 语法高亮
    "p00f/nvim-ts-rainbow",            -- 配合treesitter，不同括号颜色区分

    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
        "neovim/nvim-lspconfig",
    },

    "glepnir/lspsaga.nvim",
    "onsails/lspkind.nvim",

    -- 自动补全
    {
        "hrsh7th/nvim-cmp",
        -- event = "BufEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path", -- 文件路径
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lua",
            "octaltree/cmp-look",
            "f3fora/cmp-spell",
        },
    },

    "L3MON4D3/LuaSnip", -- snippets引擎，不装这个自动补全会出问题
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",

    "numToStr/Comment.nvim",   -- gcc和gc注释
    "windwp/nvim-autopairs",   -- 自动补全括号

    "akinsho/bufferline.nvim", -- buffer分割线
    "lewis6991/gitsigns.nvim", -- 左则git提示

    {
        "nvim-telescope/telescope.nvim",
        -- tag = "0.1.1", -- 文件检索
        dependencies = { { "nvim-lua/plenary.nvim" } }, -- requires要改为dependencies
    },
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-hop.nvim",
    "ChSotiriou/nvim-telemake",

    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup()
        end,
    },

    "mhartington/formatter.nvim",

    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    --golang
    { "ray-x/go.nvim",               lazy = true, ft = "go" },
    "ray-x/guihua.lua", -- recommended if need floating window support

    {
        "preservim/nerdtree",
        event = "BufEnter",
        setup = function()
            -- Read the following nerdtree section and add what you need
        end,
    },
    "tiagofumo/vim-nerdtree-syntax-highlight",
    "ryanoasis/vim-devicons",

    {
        "folke/flash.nvim",
        lazy = true,
    },

    "kyazdani42/nvim-web-devicons",

    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                -- open_mapping = '<C-\\>',
                -- start_in_insert = true,
                -- direction = 'float',
            })
        end,
    },

    { "folke/which-key.nvim",                lazy = true },

    { "lukas-reineke/indent-blankline.nvim", tag = "v2.20.8" },

    -- { "neoclide/coc.nvim", branch = "release" },
    "ray-x/lsp_signature.nvim",

    "suan/vim-instant-markdown",

    "glepnir/dashboard-nvim",

    "rcarriga/nvim-notify",

    "echasnovski/mini.indentscope",

    -- debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
        },
    },

    "terryma/vim-expand-region",
    -- use("terryma/vim-multiple-cursors")
    "mg979/vim-visual-multi",
    "terryma/vim-smooth-scroll",

    --cmake tool
    {
        -- "Civitasv/cmake-tools.nvim",
        "Shatur/neovim-cmake",
        lazy = true,
        ft = { "cpp", "c", "cxx", "h" },
        dependencies = { { "nvim-lua/plenary.nvim" } }, -- requires要改为dependencies
        config = function()
            require("plugins.cmake")
        end,
    },
}
local opts = {} -- 注意要定义这个变量

require("lazy").setup(plugins, opts)

