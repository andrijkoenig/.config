-- Set lualine as statusline
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local colors = {
            blue  = '#8ca0dc',
            red   = '#e6788c',
            green = '#a3cd81',
            orange = '#d2a374',
			
            grey  = '#1E1E1E',
            black = '#1a1a1a',
            white = '#e2e2e2',
        }

        local my_theme = {
            normal = {
                a = { fg = colors.black, bg = colors.blue },
                b = { fg = colors.white, bg = colors.grey },
                c = { fg = colors.white, bg = colors.grey },
            },
            insert = { a = { fg = colors.black, bg = colors.orange } },
            visual = { a = { fg = colors.black, bg = colors.green } },
            replace = { a = { fg = colors.black, bg = colors.red } },
            inactive = {
                a = { fg = colors.white, bg = colors.black },
                b = { fg = colors.white, bg = colors.black },
                c = { fg = colors.white },
            },
        }

        local lsp_server = {
            -- Lsp server name .
            function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = ' LSP:',
        }

        require('lualine').setup {
            options = {
                theme = my_theme,
                component_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'filename', 'branch' },
                lualine_c = {
                    '%=', lsp_server
                },
                lualine_x = {},
                lualine_y = { 'filetype', 'progress' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = { 'filename' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'location' },
            },
            tabline = {},
            extensions = {},
        }
    end,
}
