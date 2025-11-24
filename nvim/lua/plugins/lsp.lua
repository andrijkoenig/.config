return {
    {
        "neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
        lazy = false,            -- REQUIRED: tell lazy.nvim to start this plugin at startup
        dependencies = {
            { "j-hui/fidget.nvim", },
        },
        init = function()
        end,
        config = function()
            -- Your LSP settings here
            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
            function GetLspPath(lspPath)
                local home = vim.fn.expand('$HOME')

                local isLinux = string.find(home, "\\") == nil
                if isLinux then
                    local unixLspDirectory = "/.local/lsp"
                    return unixLspDirectory .. lspPath
                else
                    local windowsLspDirectory = home .. "/languageservers"
                    return string.gsub(windowsLspDirectory .. lspPath, "/", "\\")
                end
            end

            local roslynLspDllPath = GetLspPath("/roslyn")

            vim.env.PATH = vim.env.PATH .. ";" .. roslynLspDllPath
            vim.lsp.enable({ "roslyn_ls", "lua_ls", "angularls", "tailwindcss", "ts_ls", "clangd" })
        end,
    },
    {
        "d7omdev/nuget.nvim",
        config = function()
            require("nuget").setup()
        end,
    },
}
