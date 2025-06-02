-- Set lualine as statusline
return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local colors = {
		  blue = '#61afef',
		  green = '#98c379',
		  purple = '#c678dd',
		  cyan = '#56b6c2',
		  red1 = '#e06c75',
		  red2 = '#be5046',
		  yellow = '#e5c07b',
		  fg = '#abb2bf',
		  bg = '#282c34',
		  gray1 = '#828997',
		  gray2 = '#2c323c',
		  gray3 = '#3e4452',
		}

		local onedark_theme = {
		  normal = {
			a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
			b = { fg = colors.fg, bg = colors.gray3 },
			c = { fg = colors.fg, bg = colors.gray2 },
		  },
		  command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
		  insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
		  visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
		  terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
		  replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
		  inactive = {
			a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
			b = { fg = colors.gray1, bg = colors.bg },
			c = { fg = colors.gray1, bg = colors.gray2 },
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
		}

        require('lualine').setup {
            options = {
				icons_enabled = true,
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },				
				always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { 'branch', filename },
                lualine_c = {                },
                lualine_x = { lsp_server },
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
