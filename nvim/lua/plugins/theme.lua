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
        config = function()
            require("vague").setup({
                transparent = true
            })
        end
    }
}
