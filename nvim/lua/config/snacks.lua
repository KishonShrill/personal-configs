require("snacks").setup({
    explorer = {
        enabled = true,
        replace_netrw = true,
    },
    picker = {
        enabled = true,
        sources = {
            explorer = {
                -- ⚙️ CORE BEHAVIOR (Translating your nvim-tree settings)
                hidden = false,
                ignored = true,

                -- 📐 LAYOUT (Translating view.width = 30)
                layout = {
                    preset = "sidebar",
                    layout = { position = "left", width = 30 },
                },

                -- ⌨️ BUFFER-LOCAL KEYMAPS (Translating your `my_on_attach`)
                win = {
                    list = {
                        keys = {
                            -- Open / Expand
                            ["<Right>"] = "confirm",
                            ["<Left>"] = "explorer_close",
                            -- Help
                            ["?"] = "toggle_help_list",
                        },
                    },
                },
            },
        },
    },

    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
})
