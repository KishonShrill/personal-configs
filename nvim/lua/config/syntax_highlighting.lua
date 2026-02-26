-- In your Neovim configuration
vim.filetype.add({
    extension = {
        qss = 'css', -- Treat files ending with .qss as CSS
    },
    pattern = {
        ['%.qss$'] = 'css', -- Treat files ending with .qss as CSS
    },
})
