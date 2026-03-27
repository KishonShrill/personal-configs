vim.keymap.set("n", "<F5>", function()
  vim.cmd.UndotreeToggle()
  vim.cmd.wincmd("p") -- optional: jump to previous window
end)

