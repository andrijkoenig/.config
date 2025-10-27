return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "c_sharp", "lua", "cpp", "cmake",
                 "java", "bash", "typst",
            },
            sync_install = false,
            auto_install = false,
            highlight = {
                enable = true
            },
        })
    end
}

