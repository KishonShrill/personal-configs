local parsers = {
    "javascript",
    "typescript",
    "tsx", -- important
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
}

require("nvim-treesitter.config").setup({
    ensure_installed = parsers,
    auto_install = true,
    sync_install = false,
    highlight = {
        enable = true,
        disable = { "lhaskell" },
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})
