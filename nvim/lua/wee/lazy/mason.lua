return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd"
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                ["lua_ls"] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } }
                            }
                        }
                    })
                end,

                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                            "--fallback-style=llvm",
                        },
                    })
                end,
            },
        })

        vim.diagnostic.config({
            virtual_text = {
                prefix = '●', -- Small bullet point next to the error
                spacing = 4,
            },
            update_in_insert = true, -- Don't show errors while you're still typing
            severity_sort = true,
            float = {
                border = "rounded",
                source = "always",
            },
        })
    end,
}
