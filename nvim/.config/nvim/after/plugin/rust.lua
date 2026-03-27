-- ~/.config/nvim/after/plugin/rust.lua

-- find local buffer
local bufnr = vim.api.nvim_get_current_buf()

-- FileType specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"rust", "rs", "Rust"},
  
  callback = function(event)
    local bufnr = event.buf  -- correct buffer for this FileType

    -- You don’t need vim.schedule() here; autocmd callbacks are already safe.
    vim.keymap.set("n", "<leader>rr", ":RustRun<CR>", { buffer = bufnr })

    -- rustaceanvim remaps
    vim.keymap.set("n", "<leader>ca", function()
      vim.cmd.RustLsp("codeAction")
    end, { silent = true, buffer = bufnr })

    vim.keymap.set("n", "<leader>K", function()
      vim.cmd.RustLsp({ "hover", "actions" })
    end, { silent = true, buffer = bufnr })

    vim.keymap.set("n", "<leader>e", function()
      vim.cmd("explainError")
    end, { silent = true, buffer = bufnr })
  end,
})

-- for debugging

local dap = require('dap')
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = {"-i", "dap"}
}

dap.configurations.rust = {
  {
	name = "Launch",
	type = "gdb", 
	request = "launch",
	program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = "${workspaceFolder}",
	stopAtBegginingOfMainSubProgram = false,
  }
}
