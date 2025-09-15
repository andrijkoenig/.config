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
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = "https://github.com/seblyng/roslyn.nvim" },
})

require "mini.pick".setup()
require "mini.bufremove".setup()
require "mini.comment".setup()
require "mini.icons".setup()
require "mini.splitjoin".setup()
require "oil".setup()
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
vim.lsp.config("roslyn", {
    cmd = {
        "dotnet",
        "/opt/royslin/neutral/Microsoft.CodeAnalysis.LanguageServer.dll",
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
    },
})
vim.lsp.enable(
	{
		"lua_ls",
		"ts_ls",
		"angularls",
		"html",
		"cssls",
		"emmet_ls",
		"tailwindcss",
		"roslyn"
	}
)

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
map('n', '<leader>e', ":Oil<CR>")
map('i', '<C-e>', function() vim.lsp.completion.get() end)
map('n', '<leader>s', ':e #<CR>')
map("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map('n', '<leader>lf', vim.lsp.buf.format)
