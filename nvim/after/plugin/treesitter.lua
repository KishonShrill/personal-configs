require("nvim-treesitter.configs").setup({
    ensure_installed = {"javascript", "typescript", "lua", "python","rust","go", "vimdoc", "c"},
    sync_install = false, --if you want to load the parsers synchronously
    auto_install = true,
    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    }
})
