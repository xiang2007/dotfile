return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Added as dependency to ensure capabilities work
  },
  -- OPTIMIZATION: Only load when opening a file
  event = { "BufReadPre", "BufNewFile" },
  
  config = function()
    require("mason").setup()
    
    -- Helper to generate capabilities once
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if ok then
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
      handlers = {
        -- Default handler for all servers
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        
        -- Custom handler for clangd
        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            capabilities = capabilities,
            cmd = { "clangd", "--query-driver=**", "-I." },
          })
        end,
        
        -- Custom handler for lua_ls
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              },
            },
          })
        end,
      },
    })
  end,
}
