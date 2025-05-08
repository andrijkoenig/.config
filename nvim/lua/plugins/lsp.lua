return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
			{
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
			},
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()			
			
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})		
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>fr", require("telescope.builtin").lsp_references, {})				  

			
            require'lspconfig'.lua_ls.setup{ 
				capabilities = capabilities,
				on_attach = lsp_keymaps,
			}
			
			require'lspconfig'.ts_ls.setup{ 
				capabilities = capabilities,
				on_attach = lsp_keymaps,
			}
			
			require("lspconfig")["tinymist"].setup {
                        capabilities = capabilities,
                        settings = {
                            formatterMode = "typstyle",
                            exportPdf = "never"
                        },
                    }
			-- omnisharp languageserver
			local pid = vim.fn.getpid()

			require'lspconfig'.omnisharp.setup{ 
				capabilities = capabilities,
				on_attach = lsp_keymaps,
				enable_roslyn_analysers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				enable_decompilation_support = true,
				filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' }, 
				cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
			}
        end,
    },  {
    "williamboman/mason.nvim",
    config = function()
		require("mason").setup({
			PATH = "prepend", -- "skip" seems to cause the spawning error
		})
	end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
		ensure_installed = {
                "lua_ls",
                "ts_ls",
                "tinymist",				
                "omnisharp",
            },
	  }
    end,
  },
}
