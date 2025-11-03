vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = false
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.o.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.g.mapleader = ' '

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ higroup = 'CurSearch', timeout = 300 })
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd("hi StatusLine guibg=NONE")
        vim.cmd("hi TabLineFill guibg=NONE")
        vim.cmd("hi TabLine guibg=NONE")
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--
function GetLspPath(lspPath)
    local home = vim.fn.expand('$HOME')

    local isLinux = string.find(home, "\\") == nil
    if isLinux then
        local unixLspDirectory = "/opt"
        return unixLspDirectory .. lspPath
    else
        local windowsLspDirectory = home .. "/languageservers"
        return string.gsub(windowsLspDirectory .. lspPath, "/", "\\")
    end
end

local roslynLspDllPath = GetLspPath("/roslyn/neutral/Microsoft.CodeAnalysis.LanguageServer.dll")
vim.lsp.config("roslyn_ls", {
    cmd = {
        "dotnet",
        roslynLspDllPath,
        "--stdio",
        "--logLevel=Information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.log.get_filename()),
    },
})
vim.lsp.enable({ "lua_ls", "roslyn_ls", "angularls", "tailwindcss", "ts_ls", "clangd" })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

map("n", "<leader>q", ":q<CR>")
map("n", "<leader>w", ":w<CR>")
map('n', '<Esc>', ':noh<CR>', opts)
map('n', '<C-k>', ':wincmd k<CR>', opts)
map('n', '<C-j>', ':wincmd j<CR>', opts)
map('n', '<C-h>', ':wincmd h<CR>', opts)
map('n', '<C-l>', ':wincmd l<CR>', opts)
map('v', 'p', '"_dP', opts)
map('n', 'x', '"_x', opts)
map('n', '<leader>t', ':tabnew<CR>', opts)
map('n', '<leader>x', ':tabclose<CR>', opts)
map("n", "gd", function() vim.lsp.buf.definition() end)
map("n", "gi", function() builtin.lsp_implementations() end)
map("n", "gr", function() builtin.lsp_references(require('telescope.themes').get_dropdown({})) end)
map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)
map("n", "<leader>cf", function() vim.lsp.buf.format() end)
map("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
map("n", "<leader>rr", function() vim.lsp.buf.rename() end)

vim.cmd("colorscheme tokyonight-storm")

