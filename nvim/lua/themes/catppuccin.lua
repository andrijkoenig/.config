-- Add Catppuccin to Lazy plugin manager
return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- Set flavor to Macchiato
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
