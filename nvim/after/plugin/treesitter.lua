require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "typescript", "lua", "python", "rust", "go", "vimdoc", "c", "css" },
    sync_install = false, --if you want to load the parsers synchronously
    auto_install = true,
    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    }
})

vim.filetype.add({
    pattern = {
        ['%.qss$'] = 'css', -- Treat files ending with .qss as CSS
    },
})
