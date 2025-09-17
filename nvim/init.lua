vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.o.winborder = "rounded"
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4                  
vim.opt.expandtab = true  
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = '1.*', },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/seblyng/roslyn.nvim" },
})

require "blink.cmp".setup({
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'enter' },

    appearance = {
	  use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },	
	signature = { enabled = true },	
  })
  
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

require "mini.pick".setup()
require "mini.bufremove".setup()
require "mini.comment".setup()
require "mini.icons".setup()
require "mini.splitjoin".setup()

 require("nvim-tree").setup({
      view = {
        width = 30,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
		dotfiles = false,         -- hide dotfiles
        git_ignored = true,      -- hide gitignored files
      },
    })
 

require("nvim-treesitter").setup({
    ensure_installed = { "c_sharp", "html", 'lua', 'python', 'rust', 'tsx', 'typescript' },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        -- disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
	textobjects = {
		select = {
			enable = true,
		},
	},
})
-- lsp
vim.lsp.config("ts_ls", {})
vim.lsp.config("html", {})
vim.lsp.config("emmet_ls", {})
vim.lsp.config("cssls", {})
vim.lsp.config("tailwindcss", {})
vim.lsp.config("angularls", {
    cmd = { "ngserver", "--stdio" }
})
vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        }
    }
})
vim.lsp.config("roslyn", {
    cmd = {
        "dotnet",
        "/opt/royslin/neutral/Microsoft.CodeAnalysis.LanguageServer.dll",
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
    },
})

-- colors
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

-- keybindings
local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', require("mini.bufremove").delete)
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map("n", "<leader>b", ":Pick buffers<CR>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map('i', '<C-e>', function() vim.lsp.completion.get() end)
map('n', '<leader>s', ':e #<CR>')
map("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map('n', '<leader>lf', vim.lsp.buf.format)
