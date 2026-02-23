local M = {}

local schemastore = require("schemastore")

local function get_local_schemas()
    local schemas = {}
    local handle = io.popen("find ./schemas -name '*.schema.json' 2>/dev/null")

    if handle then
        for file in handle:lines() do
            local abs_path = vim.fn.fnamemodify(file, ":p")
            local basename = file:match("([^/]+)%.schema%.json$")

            if basename then
                table.insert(schemas, {
                    fileMatch = { "public/data/" .. basename .. ".json" },
                    url = abs_path,
                })
            end
        end
        handle:close()
    end

    return schemas
end

function M.get_json_schemas()
    return vim.tbl_extend(
        "force",
        schemastore.json.schemas({
            ignore = {
                ".eslintrc",
                "package.json",
            },
        }),
        get_local_schemas()
    )
end

return M
