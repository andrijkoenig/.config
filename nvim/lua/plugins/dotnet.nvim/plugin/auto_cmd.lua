if vim.g.loaded_dotnet_nvim ~= nil then
    return
end
vim.g.loaded_roslyn_plugin = true

local group = vim.api.nvim_create_augroup("dotnet.nvim", { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.cs',
    callback = function()
        if require("utils").current_buf_is_empty() == false then
            return
        end
        require("dotnet").insert_csharp_file_starter()
    end
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.cs",
    callback = function()
        local client = vim.lsp.get_clients({ name = "roslyn" })[1]

        if client then
            local status = client:notify('workspace/didChangeWatchedFiles', {
                changes = {
                    {
                        uri = vim.api.nvim_buf_get_name(0),
                        type = 2
                    }
                }
            })
        end
    end,
})
