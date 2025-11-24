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
vim.opt.termguicolors = true

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

-- keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local builtin = require('telescope.builtin')

map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>w", ":w<CR>", opts)
map('n', '<Esc>', ':noh<CR>', opts)
map('n', '<C-k>', ':wincmd k<CR>', opts)
map('n', '<C-j>', ':wincmd j<CR>', opts)
map('n', '<C-h>', ':wincmd h<CR>', opts)
map('n', '<C-l>', ':wincmd l<CR>', opts)
map('v', 'p', '"_dP', opts)
map('n', 'x', '"_x', opts)

map('n', '<leader>t', ':tabnew<CR>', opts)
map('n', '<leader>x', ':tabclose<CR>', opts)

map('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>b', builtin.buffers, { desc = 'Telescope Buffers' })
map('n', '<leader>ss', builtin.current_buffer_fuzzy_find, { desc = 'Telescope Fuzzy grep' })
map('n', "<leader>si", builtin.grep_string)
map('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>p', builtin.registers, { desc = 'Telescope registers' })
map('n', '<leader>lt', builtin.treesitter, { desc = 'List functions' })
map('n', '<leader>lq', '<cmd>Telescope diagnostics<CR>', { desc = 'List functions' })

map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)

map("n", "gd", builtin.lsp_definitions, opts)
map("n", "gD", vim.lsp.buf.declaration, opts)
map("n", "gi", builtin.lsp_implementations, opts)
map("n", "gr", function() builtin.lsp_references(require('telescope.themes').get_dropdown({})) end, opts)
map('n', 'gs', builtin.lsp_workspace_symbols, opts)

map("n", "<leader>cf", function() vim.lsp.buf.format({async = true}) end, opts)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

map('n', '<F2>', vim.lsp.buf.rename, opts)

