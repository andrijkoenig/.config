-- File: harpoon.lua
-- Purpose: Configure Harpoon for Neovim using Lazy

local function setup_harpoon()
    require("harpoon").setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 20, -- Customize menu width
        },
    })
end

return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    config = setup_harpoon,
}
