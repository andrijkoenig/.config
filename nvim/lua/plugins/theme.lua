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
            require('vscode').load()
        end
    }
}
