local M = {}

local schemas = require("lsp.util.schemastore").get_json_schemas()

function M.setup(capabilities)
    vim.lsp.config["jsonls"] = {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git", "schemas" },
        capabilities = capabilities,
        settings = {
            json = {
                schemas = schemas,
                validate = { enable = true },
            },
        },
    }
end

return M
