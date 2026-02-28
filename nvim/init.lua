-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugins
require("config.lazy")
require("config.settings")
require("config.remap")
require 'nvim-treesitter'.setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
}
require("config.treesitter")
require("config.snacks")
-- require("config.file_explorer")
require("config.syntax_highlighting")


local filetypes = {
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "typescript",
    "tsx",
    "typescriptreact",
    "lua",
    "python",
    "rust",
    "go",
    "c",
    "css",
    "sh", -- bash → sh
    "haskell",
    "cabal",
    "vim",
    "help", -- vimdoc → help
    "vue",
    "svelte",
    "astro",
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function()
        vim.treesitter.start()
    end,
})
