local utils = require("utils")

local M = {}

M.setup = function()

end

M.insert_csharp_file_starter = function()
    local raw_file_path     = vim.api.nvim_buf_get_name(0)
    local cleaned_file_path = utils.to_unix_path(raw_file_path)
    local file_information  = utils.parse_file_path(cleaned_file_path)

    if file_information == nil then
        return
    end

    local csharp_starter_text = {
        "namespace " .. file_information.namespace .. ";",
        "",
        "public " .. file_information.type_keyword .. " " .. file_information.type_name,
        "{",
        "",
        "}"
    }
    vim.api.nvim_buf_set_lines(0, 0, 0, false, csharp_starter_text)
    vim.api.nvim_command("write");


end

return M
