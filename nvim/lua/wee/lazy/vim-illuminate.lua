return {
    "RRethy/vim-illuminate",
    config = function()
        require('illuminate').configure({
            providers = {
                'lsp',
                'treesitter',
                'regex',
            },
            delay = 100,
            filetypes_denylist = {
                'dirvish',
                'fugitive',
                'NvimTree',
            },
            under_cursor = true,
        })
        vim.keymap.set('n', '<a-n>', function()
            require('illuminate').goto_next_reference(false)
        end, { desc = 'Next Reference' })
        vim.keymap.set('n', '<a-p>', function()
            require('illuminate').goto_prev_reference(false)
        end, { desc = 'Prev Reference' })
    end
}
