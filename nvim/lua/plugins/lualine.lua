-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {}
  end,
}
