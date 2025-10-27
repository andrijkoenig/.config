return
{
    {
        "navarasu/onedark.nvim",
        config = function()
            require('onedark').setup {
                style = 'warmer'
            }
        end
    },
    {
        'Mofiqul/vscode.nvim',
        config = function()
            require('vscode').setup()
        end
    },
    {
        'vague-theme/vague.nvim',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other plugins
        config = function()
            require("vague").setup({
                transparent = true
            })
            vim.cmd("colorscheme vague")
        end
    }
}
