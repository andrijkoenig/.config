return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        -- This is your opts table
        require("telescope").setup {
            defaults = {
                color_devicons = true,
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                    width = 9999,
                    height = 9999,
                }
            }
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope Buffers' })
        vim.keymap.set('n', '<leader>ss', builtin.current_buffer_fuzzy_find, { desc = 'Telescope Fuzzy grep' })
        vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>p', builtin.registers, { desc = 'Telescope registers' })
        vim.keymap.set('n', '<leader>lt', builtin.treesitter, { desc = 'List functions' })
        vim.keymap.set('n', '<leader>lq', '<cmd>Telescope diagnostics<CR>', { desc = 'List functions' })
    end,
}
