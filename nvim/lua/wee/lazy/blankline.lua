return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- In V3, the main module is 'ibl'
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require "ibl.hooks"
        -- create the highlight groups in the context of the current theme
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E82424" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E6C384" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#7E9CD8" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FFA066" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98BB6C" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#957FB8" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#7AA89F" })
        end)

        require("ibl").setup({
            indent = {
                char = "▎", -- Use a clean vertical bar (works with Nerd Fonts)
                tab_char = "▎",
            },
            scope = {
                enabled = false, -- Highlights the current indentation level
                show_start = false,
                show_end = false,
                highlight = highlight, -- This adds the "Rainbow" effect to the scope
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "lazy",
                    "mason",
                },
            },
        })
    end
}
