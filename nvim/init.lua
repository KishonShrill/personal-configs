-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- plugins
require("config.lazy")
require("config.settings")
require("config.remap")
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
    "rust",
    "go",
    "c",
    "css",
    "haskell",
    "lhaskell",
    "cabal",
    "help", -- vimdoc → help
    "vue",
    "svelte",
    "astro",
    "python",
}

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = filetypes,
--     callback = function()
--         vim.treesitter.start()
--     end,
-- })
