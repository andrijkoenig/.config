-- File: telescope.lua
-- Purpose: Configure Telescope for Neovim using Lazy

local function setup_telescope()
    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            mappings = {
                i = {
                    ["<C-u>"] = false, -- Clear input
                    ["<C-d>"] = false, -- Delete input
                },
            },
        },
        pickers = {
            find_files = {
                hidden = true, -- Show hidden files
            },
        },
    })

    -- Load Telescope extensions if any
    pcall(telescope.load_extension, "fzf") -- Example for FZF extension
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Telescope dependency
    config = setup_telescope,
}
