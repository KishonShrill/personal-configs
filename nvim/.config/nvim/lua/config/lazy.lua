-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" },
            { "\nPress any key to exit..." }
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- 🌈 Colorschemes
        { "Tsuzat/NeoSolarized.nvim", lazy = false,        priority = 1000 },
        { "rebelot/kanagawa.nvim" },
        { "lunarvim/darkplus.nvim" },
        { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },


        -- ⚙️ Core Plugins
        { "nvim-lua/plenary.nvim" },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "main",
            lazy = false,
            build = ":TSUpdate",
            init = function()
                local parser_installed = {
                    "javascript",
                    "typescript",
                    "tsx",
                    "lua",
                    "luadoc",
                    "python",
                    "rust",
                    "go",
                    "vimdoc",
                    "c",
                    "css",
                    "bash",
                    "haskell",
                    "vim",
                    "query",
                    "markdown_inline",
                    "markdown",
                }

                vim.defer_fn(function() require("nvim-treesitter").install(parser_installed) end, 1000)
                require("nvim-treesitter").update()

                -- auto-start highlights & indentation
                vim.api.nvim_create_autocmd("FileType", {
                    desc = "User: enable treesitter highlighting",
                    callback = function(ctx)
                        -- highlights
                        local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

                        -- indent
                        local noIndent = {}
                        if hasStarted and not vim.list_contains(noIndent, ctx.match) then
                            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end,
                })
            end
        },
        {
            "nvim-telescope/telescope.nvim",
            branch = "master",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        { "nvim-lualine/lualine.nvim" },
        { "mbbill/undotree" },
        { "tpope/vim-fugitive" },
        { "nvim-tree/nvim-web-devicons" },
        -- { "nvim-tree/nvim-tree.lua" },
        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            keys = {
                {
                    "<leader>gG",
                    function() Snacks.terminal({ "gitui" }) end,
                    desc = "GitUi (cwd)",
                },
                {
                    "<leader>gg",
                    function() Snacks.terminal({ "gitui" }, { cwd = vim.fn.getcwd() }) end,
                    desc = "GitUi (Root Dir)",
                },
            }
        },
        { 'akinsho/toggleterm.nvim', version = "*", config = true },


        -- ✂️ Snippets & Completion
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/nvim-cmp" },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            dependencies = {
                "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets"
            }
        },


        -- 🔧 LSP & Tools
        { "mason-org/mason.nvim", opts = {} },
        {
            "mason-org/mason-lspconfig.nvim",
            dependencies = {
                "mason-org/mason.nvim",
                "neovim/nvim-lspconfig"
            },
        },
        { "b0o/schemastore.nvim" },


        -- 🦀 Language-specific
        {
            "ray-x/go.nvim",
            dependencies = { "ray-x/guihua.lua" },
            config = function() require("go").setup() end,
            event = { "CmdlineEnter" },
            ft = { "go", "gomod" },
            lazy = false
        },
        { "mrcjkb/rustaceanvim",        version = "^4", lazy = true, ft = { "rust" } },
        { "lark-parser/vim-lark-syntax" },
        {
            "nvim-neorg/neorg",
            lazy = false,
            version = "*",
            config = true,
        },


        -- 🐞 Debugging
        "mfussenegger/nvim-dap",
        {
            "stevearc/conform.nvim",
            config = function()
                require("conform").setup({
                    -- your config here
                })
            end
        },
    },
    opts = {},
    checker = { enabled = false } -- automatically check for plugin updates
})
