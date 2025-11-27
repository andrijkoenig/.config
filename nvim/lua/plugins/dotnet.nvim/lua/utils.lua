local M = {}

local WarningMsg = function(text)
    vim.api.nvim_echo({ { text, "WarningMsg" } }, false, {})
end

local to_unix_path = function(path)
    return string.gsub(path, "\\", "/")
end

local is_charp_file = function(filename)
    return string.sub(filename, - #'.cs') == '.cs'
end

local is_current_buf_empty = function()
    return #vim.api.nvim_buf_get_lines(0, 1, -1, false) == 0
end

---@class dotnet.ProjectInformation
---@field project_dir string
---@field project_file string

---@param file_path string
---@return dotnet.ProjectInformation|nil
M.get_project_dir = function(file_path)
    local parent_dir = function(path)
        return path:match("(.+)/[^/]+$")
    end

    local current_dir = parent_dir(file_path)

    local project_dir = nil;
    while project_dir == nil and current_dir:match("/") do
        local dotnet_project_file_extensions_patterns = { ".csproj$", ".sln$", ".slnx$", ".slnf$" }
        local files = require('plenary.scandir').scan_dir(current_dir,
            { depth = 1, search_pattern = dotnet_project_file_extensions_patterns })
        local dotnet_project_file_found = #files ~= 0
        if dotnet_project_file_found then
            return {
                project_dir = current_dir,
                project_file = files[1]
            }
        end
        current_dir = parent_dir(current_dir)
    end

    WarningMsg("Current directory is not a .NET project")
    return nil
end

---@class dotnet.FileInformation
---@field namespace string
---@field type_name string
---parses the file_path to get the namespace and class_name
---@param file_path string an already cleaned up unix path
---@return dotnet.FileInformation|nil # table with the namespace and class_name information
M.get_namespace = function(file_path)
    local project_dir = M.get_project_dir(file_path).project_dir

    -- namespace
    local start_index = string.find(project_dir, "/[^/]*$") + 1
    local end_index = string.find(file_path, "/[^/]*$") - 1

    local path_from_project_to_target = file_path:sub(start_index, end_index)
    local namespace = path_from_project_to_target:gsub("/", ".")

    -- class
    local type_name = string.match(file_path, ".*/([^/]+)%.cs$")

    return {
        namespace = namespace,
        type_name = type_name,
    }
end

M.insert_csharp_file_starter_into_current_buffer = function(is_interface)

    if is_current_buf_empty() == false then
        WarningMsg("Current buffer is not empty, stopped insertion for security")
        return
    end

    local raw_file_path = vim.api.nvim_buf_get_name(0)

    if is_charp_file(raw_file_path) == false then
        WarningMsg("Not a C# (.cs) file")
        return
    end


    local cleaned_file_path = to_unix_path(raw_file_path)
    local file_information  = M.get_namespace(cleaned_file_path)

    if file_information == nil then
        return
    end

    local type_keyword = "class"
    if is_interface then
        type_keyword = "interface"
    end

    local csharp_starter_text = {
        "namespace " .. file_information.namespace .. ";",
        "",
        "public " .. type_keyword .. " " .. file_information.type_name,
        "{",
        "",
        "}"
    }
    vim.api.nvim_buf_set_lines(0, 0, 1, false, csharp_starter_text)
    vim.api.nvim_command("write");
end


return M
