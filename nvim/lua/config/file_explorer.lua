local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- buffer-local mappings
    vim.keymap.set("n", "l", api.node.open.edit, opts("Open File or Expand Folder"))
    vim.keymap.set("n", "<Right>", api.node.open.edit, opts("Open File or Expand Folder"))

    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Folder"))
    vim.keymap.set("n", "<Left>", api.node.navigate.parent_close, opts("Close Folder"))

    vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
    on_attach = my_on_attach,
    modified = {
        enable = true,
        show_on_dirs = true,
    },
    git = {
        enable = true,
        ignore = false,
    },
})

-- 🔑 global keymap for toggle (works even when nvim-tree is closed)
vim.keymap.set("n", "<leader>>", function()
    require("nvim-tree.api").tree.close()
end, { desc = "Toggle NvimTree", noremap = true, silent = true })

-- 🔑 global keymap: Ctrl + Left focuses the tree
vim.keymap.set("n", "<leader><", function()
    require("nvim-tree.api").tree.open()
end, { desc = "Focus NvimTree", noremap = true, silent = true })
