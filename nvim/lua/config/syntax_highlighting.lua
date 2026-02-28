-- In your Neovim configuration
vim.filetype.add({
    extension = {
        qss = 'css', -- Treat files ending with .qss as CSS
    },
    pattern = {
        ['%.qss$'] = 'css', -- Treat files ending with .qss as CSS
        ['%.config'] = 'ini',
        ['%.conf'] = 'ini',
    },
})

-- ini files
vim.api.nvim_set_hl(0, "@markup.heading.ini", { fg = "#C4A4DB", bold = true })
vim.api.nvim_set_hl(0, "@comment.ini", { fg = "#74B386" })
