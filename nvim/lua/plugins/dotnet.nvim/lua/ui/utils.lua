local M = {}

M.get_dotnet_templates = function(opts)
    opts = opts or {}
    local cmd = "dotnet new list --columns-all"
    local cmd_result = vim.fn.system(cmd)

    local lines = {}
    for line in cmd_result:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    local result = {}
    for index, value in ipairs(lines) do
        if index > 4 then
            value = value:gsub("  ", "~")

            local row = {}
            for part in value:gmatch("[^~]+") do
                local trimmed = part:match("^%s*(.-)%s*$")
                table.insert(row, trimmed)
            end

            table.insert(result, row)
        end
    end
    return result
end

return M
