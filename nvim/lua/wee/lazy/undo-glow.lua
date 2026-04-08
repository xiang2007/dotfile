return {
    "y3owk1n/undo-glow.nvim",
    event = { "VeryLazy" },
    ---@type UndoGlow.Config
    opts = {
        animation = {
            enabled = true,
            duration = 300,
            animation_type = "zoom",
            window_scoped = true,
        },
        highlights = {
            undo = { hl_color = { bg = "#693232" } },     -- Dark muted red
            redo = { hl_color = { bg = "#2F4640" } },     -- Dark muted green
            yank = { hl_color = { bg = "#7A683A" } },     -- Dark muted yellow
            paste = { hl_color = { bg = "#325B5B" } },    -- Dark muted cyan
            search = { hl_color = { bg = "#5C475C" } },   -- Dark muted purple
            comment = { hl_color = { bg = "#7A5A3D" } },  -- Dark muted orange
            cursor = { hl_color = { bg = "#793D54" } },   -- Dark muted pink
        },
        priority = 6144, -- 2048 * 3
    },
    keys = {
        -- Undo/Redo (Using U for redo)
        { "u", function() require("undo-glow").undo() end, mode = "n", desc = "Undo with highlight" },
        { "U", function() require("undo-glow").redo() end, mode = "n", desc = "Redo with highlight" },
        
        -- Paste
        { "p", function() require("undo-glow").paste_below() end, mode = "n", desc = "Paste below with highlight" },
        { "P", function() require("undo-glow").paste_above() end, mode = "n", desc = "Paste above with highlight" },
        
        -- Search (Using strobe for better visibility)
        { "n", function() require("undo-glow").search_next({ animation = { animation_type = "strobe" } }) end, mode = "n", desc = "Search next" },
        { "N", function() require("undo-glow").search_prev({ animation = { animation_type = "strobe" } }) end, mode = "n", desc = "Search prev" },
        { "*", function() require("undo-glow").search_star({ animation = { animation_type = "strobe" } }) end, mode = "n", desc = "Search star" },
        { "#", function() require("undo-glow").search_hash({ animation = { animation_type = "strobe" } }) end, mode = "n", desc = "Search hash" },

        -- Comments
        { "gcc", function() return require("undo-glow").comment_line() end, mode = "n", expr = true, desc = "Comment line" },
        { "gc", function() return require("undo-glow").comment() end, mode = { "n", "x" }, expr = true, desc = "Comment motion" },
    },
    init = function()
        -- Yank Highlight
        vim.api.nvim_create_autocmd("TextYankPost", {
            callback = function() require("undo-glow").yank() end,
        })

        -- Cursor Move (Slide animation)
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = function()
                require("undo-glow").cursor_moved({ animation = { animation_type = "slide" } })
            end,
        })

        -- Cmdline search (Fade)
        vim.api.nvim_create_autocmd("CmdlineLeave", {
            callback = function()
                require("undo-glow").search_cmd({ animation = { animation_type = "fade" } })
            end,
        })
    end,
}
