return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup({
        ensure_installed = { "lua", "rust", "c", "cpp", "python", "javascript", "typescript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  end,
}