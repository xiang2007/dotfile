return {
    "kevinhwang91/nvim-hlslens",
    config = function()
        require('hlslens').setup({
            -- We leave override_lens out to let the plugin handle the math
            -- and avoid the "arithmetic on a table" error.
            auto_enable = true,
            enable_incsearch = true,
        })

        local kopts = {noremap = true, silent = true}

        -- Standard search navigation with automatic lens triggering
        vim.keymap.set('n', 'n',
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts)
        vim.keymap.set('n', 'N',
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts)

        -- Star search (word under cursor)
        vim.keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
        vim.keymap.set('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)

        -- Clear search highlights with Leader + l
        vim.keymap.set('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
    end
}
