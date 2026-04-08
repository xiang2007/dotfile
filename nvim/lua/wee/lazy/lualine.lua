return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                -- Oxocarbon has a built-in lualine theme!
                theme = 'oxocarbon',
                
                -- Use thin separators for a more "IBM/Carbon" minimalist look
                component_separators = { left = '｜', right = '｜' },
                section_separators = { left = '', right = '' },
                
                disabled_filetypes = {
                    statusline = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
                },
                globalstatus = true, -- Keep a single bar at the bottom
            },
            sections = {
                lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 
                    { 'filename', file_status = true, path = 1 } -- 1 = Relative path (good for 42 projects)
                },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        })
    end
}
