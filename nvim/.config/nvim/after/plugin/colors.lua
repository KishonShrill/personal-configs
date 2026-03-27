-- assuming you added {'rebelot/kanagawa.nvim'} to your lazy.lua file for your colorscheme
-- ~/.config/nvim/after/plugin/colors.lua

require("catppuccin").setup({
    flavour = "auto", -- auto, latte, frappe, macchiato, mocha
    background = {
        light = "frappe",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    float = {
        transparent = true,
        solide = false
    },
    styles = {
        comment = { "italic" },
        keyword = { "italic" },
        functions = { "bold" },
        strings = { "italic" },
        booleans = { "bold" },
        underline = true,
        undercurl = true,
    },
    default_integrations = true,
    auto_integrations = true,
    integrations = {
        telescope = { enabled = true, },
        treesitter_context = true,
    }
})
vim.cmd.colorscheme "catppuccin-nvim"
-- NeoSolarized
-- dakrplus
-- kanagawa
-- catppuccin
