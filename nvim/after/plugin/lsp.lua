require("mason").setup({})
require("mason-lspconfig").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- =========================
-- Server Overrides
-- =========================

local lsp_group = vim.api.nvim_create_augroup("LspConfig", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf
        local opts = { buffer = bufnr, remap = false }

        -- format on save
        if client.server_capabilities.documentFormattingProvider then
            local format_group = vim.api.nvim_create_augroup(
                "LspFormat" .. bufnr,
                { clear = true }
            )

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = format_group,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end
            })
        end

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)                --go to definition
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)                      -- hover
        vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts) --view workspace
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)     --view diagnostic
        vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts) --view code action
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)      --rename variables
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>h', vim.lsp.buf.signature_help, opts)
    end
})

-- JSON
require("lsp.json").setup(capabilities)

-- TypeScript
require("lsp.ts_ls").setup(capabilities)

-- JavaScript/TypeScript
require("lsp.eslint").setup(capabilities)

-- Python
require("lsp.basedpyright").setup(capabilities)

-- =========================
-- Auto Enable Everything Installed
-- =========================

for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
    if not vim.lsp.config[server] then
        vim.lsp.config[server] = {
            capabilities = capabilities,
        }
    end
    vim.lsp.enable(server)
end
