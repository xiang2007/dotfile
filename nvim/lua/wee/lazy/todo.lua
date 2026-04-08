return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX  = { icon = "󰅚 ", color = "error", alt = { "FIXME", "BUG" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = "󱐌 ", color = "warning" }, 
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } }, 
      PERF = { icon = "󰓅 ", color = "default" },
      NOTE = { icon = "󰍨 ", color = "hint" },
      TEST = { icon = "󰙨 ", color = "test" },
    },
    gui_style = {
      fg = "ITALIC", -- Gives it a slightly "hand-drawn" look
      bg = "BOLD",   -- Keeps the wax-block look
    },
    highlight = {
      multiline = true,
      bg_decode = true,
      keyword = "wide_bg",    -- This creates the "thick stroke" effect
      after = "fg",           
      pattern = [[.*<(KEYWORDS)\s*]], 
      comments_only = false,  
    },
    -- CRAYON / HIGHLIGHTER PALETTE
    colors = {
      error   = { "#FF5555" }, -- Strawberry Crayon
      warning = { "#FFEF00" }, -- Canary/Dandelion Yellow
      info    = { "#00CCFF" }, -- Sky Blue Crayon
      hint    = { "#12E193" }, -- Electric Lime
      default = { "#9D81FF" }, -- Soft Purple Pastel
      test    = { "#FF66FF" }, -- Bubblegum Pink
    },
  },
  keys = {
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search Todos" },
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
  }
}
