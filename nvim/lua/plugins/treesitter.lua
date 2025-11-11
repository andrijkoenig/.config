return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "c_sharp", "lua", "cpp", "cmake",
                    "java", "bash", "typst",
                },
                sync_install = true,
                auto_install = false,
                highlight = {
                    enable = true
                },
            })
        end
    },
    {
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require('treesj').setup({ --[[ your config ]] })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require 'colorizer'.setup()
        end
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
}
