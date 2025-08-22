-- assuming you added {'rebelot/kanagawa.nvim'} to your lazy.lua file for your colorscheme
-- ~/.config/nvim/after/plugin/colors.lua

require("catppuccin").setup({
	flavour = "frappe", -- auto, latte, frappe, macchiato, mochai
	background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
	styles = {
		comment = { "italic" },
		keyword = { "italic" },
		functions = { "bold" },
		strings = { "italic" },
		booleans = { "bold" },
		underline = true,
		undercurl = true,
	},
    integrations = {
        cmp = true,
        nvimtree = true,
        treesitter = true,
	},
})

vim.cmd.colorscheme("catppuccin")
-- NeoSolarized
-- dakrplus
-- kanagawa
-- catppuccin
