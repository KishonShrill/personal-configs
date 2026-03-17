-- In your Neovim configuration
vim.filetype.add({
    extension = {
        qss = 'css', -- Treat files ending with .qss as CSS
        sh = 'bash',
    },
    filename = {
        -- Exact matches for your Git setup files
        ['config'] = 'bash',
        ['ignore'] = 'bash',
        ['template'] = 'bash',

        -- You can also add the dot-prefixed versions just to be safe
        ['.gitconfig'] = 'bash',
        ['.gitignore'] = 'bash',
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
