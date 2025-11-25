local M = {}

--- Helper function to convert a windows path to a unix path
---@param path string a windows path
---@return string unix_path cleaned up unix path
M.to_unix_path = function(path)
    return string.gsub(path, "\\", "/")
end

M.is_charp_file = function(filename)
    return string.sub(filename, - #'.cs') == '.cs'
end

M.current_buf_is_empty = function()
    return #vim.api.nvim_buf_get_lines(0, 1, -1, false) == 0
end



---@class dotnet.FileInformation
---@fields namespace string
---@fields type_name string
---@fields type_keyword string

--- parses the file_path to get the namespace and class_name
---@param file_path string an already cleaned up unix path
---@return dotnet.FileInformation|nil # table with the namespace and class_name information
M.parse_file_path = function(file_path)
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
            project_dir = current_dir
            break;
        end

        current_dir = parent_dir(current_dir)
    end

    if project_dir == nil then
        print("Current direcotry is not a .net project")
        return nil
    end

    -- namespace
    local start_index = string.find(project_dir, "/[^/]*$") + 1
    local end_index = string.find(file_path, "/[^/]*$") - 1

    local path_from_project_to_target = file_path:sub(start_index, end_index)
    local namespace = path_from_project_to_target:gsub("/", ".")

    -- class 
    local type_name = string.match(file_path, ".*/([^/]+)%.cs$")
    local type_keyword = "class"

    local is_interface = string.match(type_name, "^I") == "I"
    if is_interface then
        type_keyword = "interface"
    end

    return {
        namespace = namespace,
        type_name = type_name,
        type_keyword = type_keyword
    }
end



return M
