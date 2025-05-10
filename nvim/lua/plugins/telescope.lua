return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
	'nvim-telescope/telescope-ui-select.nvim'
  },
  config = function()
  -- This is your opts table
	require("telescope").setup {
	  extensions = {
		["ui-select"] = {
		  require("telescope.themes").get_dropdown {}
		}
	  }
	}
	require("telescope").load_extension("ui-select")  
  
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
	vim.keymap.set('n', '<leader>lt', builtin.treesitter, { desc = 'List functions' })
	vim.keymap.set('n', '<leader>lq', '<cmd>Telescope diagnostics<CR>', { desc = 'List functions' })
  end,
}
