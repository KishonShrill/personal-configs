local M = {}

local schemastore = require("schemastore")

local function get_local_schemas()
    local schemas = {}
    -- local handle = io.popen("find ./schemas -name '*.schema.json' 2>/dev/null")
    local files = vim.fn.glob("./schemas/**/*.schema.json", true, true)

    -- if handle then
    if files then
        -- for file in handle:lines() do
        for _, file in ipairs(files) do
            local abs_path = vim.fn.fnamemodify(file, ":p")
            local basename = file:match("([^/]+)%.schema%.json$")

            if basename then
                table.insert(schemas, {
                    fileMatch = { "public/data/" .. basename .. ".json" },
                    -- url = abs_path,
                    url = "file://" .. abs_path, -- Added file:// protocol for LSP
                })
            end
        end
        -- handle:close()
    end

    return schemas
end

function M.get_json_schemas()
    local global_schemas = schemastore.json.schemas({
        ignore = {
            ".eslintrc",
            "package.json",
        },
    })

    local local_schemas = get_local_schemas()

    return vim.list_extend(global_schemas, local_schemas)

    -- return vim.tbl_extend(
    --     "force",
    --     schemastore.json.schemas({
    --         ignore = {
    --             ".eslintrc",
    --             "package.json",
    --         },
    --     }),
    --     get_local_schemas()
    -- )
end

return M
