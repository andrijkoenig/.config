return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
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
        "Hoffs/omnisharp-extended-lsp.nvim",
        'saghen/blink.cmp',
		'nvim-telescope/telescope.nvim' ,
    },

    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = false,
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "tinymist",
                "omnisharp",
                "angularls",
                "jdtls",
				"html",
				"cssls",
				"emmet_ls",
				"tailwindcss",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["tinymist"] = function()
                    require("lspconfig")["tinymist"].setup {
                        capabilities = capabilities,
                        settings = {
                            formatterMode = "typstyle",
                            exportPdf = "never"
                        },
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["ts_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.ts_ls.setup {
                        capabilities = capabilities,
                    }
                end,
				["angularls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.angularls.setup {
                        capabilities = capabilities,
                    }
                end,
				["jdtls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.jdtls.setup {
                        capabilities = capabilities,
                    }
                end,
                ["omnisharp"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.omnisharp.setup {
                        capabilities = capabilities,
                        enable_roslyn_analysers = true,
                        enable_import_completion = true,
                        organize_imports_on_format = true,
                        enable_decompilation_support = true,
                        filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets', 'tproj', 'slngen', 'fproj' },
                        handlers = {
                            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                            ["textDocument/references"] = require('omnisharp_extended').references_handler,
                            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
                        },
                    }
                end,
				["html"] = function()
					require("lspconfig").html.setup {
						capabilities = capabilities,
					}
				end,

				["cssls"] = function()
					require("lspconfig").cssls.setup {
						capabilities = capabilities,
					}
				end,

				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup {
						capabilities = capabilities,
					}
				end,

				["emmet_ls"] = function()
					require("lspconfig").emmet_ls.setup {
						capabilities = capabilities,
						filetypes = {
							"html", "css", "scss", "javascript", "javascriptreact",
							"typescript", "typescriptreact", "svelte"
						},
					}
				end,

            }

        })

        vim.api.nvim_create_autocmd('LspAttach', {		
            callback = function(e)						
				local builtin = require('telescope.builtin')
				
				vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to Definition", buffer = e.buf })
				vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, { desc = "Go to Implementation ", buffer = e.buf })
				vim.keymap.set("n", "gr", function() builtin.lsp_references() end, { desc = "Show References", buffer = e.buf })
                vim.keymap.set("n", "K",  function() vim.lsp.buf.hover() end, { buffer = e.buf, desc = "Hover Documentation" })
                vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, { buffer = e.buf, desc = "Format Document" })
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { buffer = e.buf, desc = "Code Actions" })
                vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, { buffer = e.buf, desc = "Rename Symbol" })
            end
        })
    end
}
