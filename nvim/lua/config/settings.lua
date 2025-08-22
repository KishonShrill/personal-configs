-- ~/.config/nvim/lua/config/settings.lua

-- line numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- set tab spaces to 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- hand off undoing to undotree plugin and don't keep a swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim.undodir"
vim.opt.undofile = true

-- set incremental search. This helps immensly with tricky searches
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- fast update time
vim.opt.updatetime = 50

-- color column to 80 characters
vim.opt.colorcolumn = "80"

-- filetype trigger
vim.opt.filetype='on'

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- set escape to enter normal mode in terminal buffer
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader><leader>term", ':belowright split | terminal<CR>', 
    {noremap = true, silent=true})





