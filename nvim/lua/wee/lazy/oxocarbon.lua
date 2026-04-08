return {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000, -- Load this first
    config = function()
        vim.opt.background = "dark" -- or "light" if you're feeling brave
        vim.cmd("colorscheme oxocarbon")

        -- Optional: Fix for floating windows to look cleaner in Oxocarbon
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#393939" })
    end
}
