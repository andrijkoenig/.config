-- Set lualine as statusline
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local colors = {
            blue     = '#007acc',
            green    = '#6A9955',
            purple   = '#C586C0',
            cyan     = '#4EC9B0',
            red1     = '#F44747',
            red2     = '#D16969',
            yellow   = '#DCDCAA',
            fg       = '#D4D4D4',
            bg       = '#1E1E1E',
            grayText = '#808080',
            gray    = '#1f1f1f',
        }

        local vscode_theme = {
            normal   = {
                a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
                b = { fg = colors.fg, bg = colors.gray },
                c = { fg = colors.fg, bg = colors.gray },
            },
            command  = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
            insert   = { a = { fg = colors.bg, bg = colors.green, gui = 'bold' } },
            visual   = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
            terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
            replace  = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
            inactive = {
                a = { fg = colors.grayText, bg = colors.bg, gui = 'bold' },
                b = { fg = colors.grayText, bg = colors.bg },
                c = { fg = colors.grayText, bg = colors.gray },
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
            icon = ' ',
        }
        local mode = {
            'mode',
            fmt = function(str)
                -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
                return ' ' .. str
            end,
        }

        local filename = {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
            fmt = function (str)
                local prefix = str:match("^[^%.]+")
                return prefix
            end
        }

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = vscode_theme,
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { 'branch' },
                lualine_c = {},
                lualine_x = { lsp_server },
                lualine_y = { 'filetype' },
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
