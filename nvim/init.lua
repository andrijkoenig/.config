require 'core.options'  -- Load general options
require 'core.keymaps'  -- Load general keymaps

-- Bootstrap Lazy plugin manager
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

-- Setup Lazy and load plugins
require("lazy").setup({
    require("themes.catppuccin"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.mini-icons"),
	require("plugins.neotree"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.which-key"),
})
