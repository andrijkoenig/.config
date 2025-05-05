return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "jcha0713/cmp-tw2css",
      "L3MON4D3/LuaSnip",
    },

    config = function()
      -- UI: Diagnostics and borders
      vim.diagnostic.config({ float = { border = "rounded" } })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white" })
      vim.api.nvim_set_hl(0, "CmpNormal", {})

      -- Custom hover handler
      local lsp = vim.lsp
      lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
        config = config or { border = "rounded", focusable = true }
        config.focus_id = ctx.method
        if not (result and result.contents) then return end
        local markdown_lines = lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.tbl_filter(function(line) return line ~= "" end, markdown_lines)
        if vim.tbl_isempty(markdown_lines) then return end
        return lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end

      -- Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "jdtls",
          "ts_ls",
          "omnisharp",
          "tinymist",
          "angularls",
          "tailwindcss",
        },
      })

      -- Autocompletion
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = function() end,
        }),
        window = {
          completion = {
            border = "rounded",
            scrollbar = false,
            winhighlight = "Normal:CmpNormal",
          },
          documentation = {
            border = "rounded",
            scrollbar = false,
            winhighlight = "Normal:CmpNormal",
          },
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
          },
          { name = "cmp-tw2css" },
        }),
      })

      -- Capabilities
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- LSP Server setup
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
            root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
          })
        end,

        ["angularls"] = function()
          lspconfig.angularls.setup({
            capabilities = capabilities,
            cmd = { "ngserver", "--stdio" },
            filetypes = { "typescript", "html", "typescriptreact" },
            root_dir = lspconfig.util.root_pattern("angular.json", ".git"),
            on_new_config = function(new_config)
              new_config.cmd = { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" }
            end,
          })
        end,

        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            capabilities = capabilities,
          })
        end,

        ["tinymist"] = function()
          lspconfig.tinymist.setup({
            capabilities = capabilities,
            settings = {
              formatterMode = "typstyle",
              exportPdf = "never",
            },
          })
        end,

        ["jdtls"] = function()
          lspconfig.jdtls.setup({
            capabilities = capabilities,
            cmd = { "jdtls" },
          })
        end,

        ["omnisharp"] = function()
          lspconfig.omnisharp.setup({
            capabilities = capabilities,
            cmd = { "omnisharp" },
          })
        end,
      })

      -- Centralized keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local opts = { buffer = e.buf }
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { silent = true, noremap = true }))
          end

          map("n", "gd", vim.lsp.buf.definition)
          map("n", "gr", vim.lsp.buf.references)
          map("n", "gi", vim.lsp.buf.implementation)
          map("n", "K", vim.lsp.buf.hover)
          map("n", "<leader>rr", vim.lsp.buf.rename)
          map("n", "<leader>ca", vim.lsp.buf.code_action)
          map("n", "<leader>cf", vim.lsp.buf.format)
          map("n", "<leader>ck", vim.diagnostic.open_float)
          map("n", "<leader>cn", vim.diagnostic.goto_next)
          map("n", "<leader>cp", vim.diagnostic.goto_prev)
        end,
      })

      -- GLSL filetype detection
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
        pattern = { "*.vert", "*.frag" },
        callback = function()
          vim.cmd("set filetype=glsl")
        end,
      })
    end,
  },
}
