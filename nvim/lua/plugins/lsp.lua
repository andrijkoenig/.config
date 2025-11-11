return {
{
  "neovim/nvim-lspconfig",
},
{
  "d7omdev/nuget.nvim",
  config = function()
    require("nuget").setup()
  end,
},
{
  "Decodetalkers/csharpls-extended-lsp.nvim",
},
{
  "mfussenegger/nvim-jdtls",
}
}
