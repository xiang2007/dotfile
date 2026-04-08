return {
    "josstei/whisk.nvim",
    event = "VeryLazy",
    opts = {
        cursor = {
            duration = 150,
            easing = "ease-out",
            enabled = true,
        },
        scroll = {
            duration = 200,
            easing = "ease-in-out",
            enabled = true,
        },
        keymaps = {
            cursor = true,
            scroll = true,
        },
        performance = {
            enabled = false,
            disable_syntax_during_scroll = true,
            ignore_events = { "WinScrolled", "CursorMoved", "CursorMovedI" },
            auto_enable_on_large_files = true,
            large_file_threshold = 5000,
        },
    }
}
