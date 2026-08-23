-- oil.nvim: edit your filesystem like a buffer
-- Open with <leader>o, navigate with Enter / -, open files with Enter

vim.pack.add { { src = 'https://github.com/stevearc/oil.nvim', version = vim.version.range '*' } }

require('oil').setup {
  default_file_explorer = true, -- make :Explore / :e . use oil instead of netrw
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '<leader>o', '<Cmd>Oil<CR>', { desc = '[O]pen file browser (oil)' })
