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
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
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

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
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
