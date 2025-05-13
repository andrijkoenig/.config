-- Leader Key
vim.g.mapleader = " "

-- UI Settings
vim.wo.number = true                     -- Show line numbers
vim.o.relativenumber = true             -- Enable relative numbered lines
vim.o.cursorline = false                -- Do not highlight the current line
vim.opt.termguicolors = true            -- Redundant but safe for compatibility
vim.opt.wrap = true
vim.opt.scrolloff = 4                   -- Keep 4 lines visible when scrolling
vim.opt.signcolumn = "yes"              -- Always show sign column
vim.o.winborder = "rounded"

-- Search
vim.o.hlsearch = true
vim.opt.incsearch = true                -- Show search matches as you type
vim.opt.ignorecase = true               -- Ignore case in search patterns

-- Clipboard and Mouse
vim.o.clipboard = 'unnamedplus'         -- Use system clipboard

-- Performance
vim.o.updatetime = 250                  -- Faster update time
vim.o.timeoutlen = 500                  -- Shorter timeout for key mappings

-- Tabs and Indentation
vim.opt.tabstop = 4                     -- Number of spaces for a tab
vim.opt.softtabstop = 4                 -- Number of spaces for soft tab
vim.opt.shiftwidth = 4                  -- Indentation amount
vim.opt.expandtab = true                -- Use spaces instead of tabs
vim.opt.smartindent = false             -- Disable smart indenting

-- Files and Backups
vim.opt.swapfile = false                -- Don't use swap file
vim.opt.backup = false                  -- Don't create backup files
vim.opt.undofile = true                 -- Enable persistent undo
