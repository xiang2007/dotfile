return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  -- The init function runs BEFORE the plugin is loaded.
  -- This is the most important part for Barbar.
  init = function() 
    vim.g.barbar_auto_setup = false 
  end,
  opts = {
    animation = false,
    auto_hide = false,
    icons = {
      filetype = { enabled = true },
      button = '×',
    },
  },
  -- Keys are separate to ensure they don't break the load sequence
  keys = {
    { '<S-h>', '<Cmd>BufferPrevious<CR>', desc = 'Prev Tab' },
    { '<S-l>', '<Cmd>BufferNext<CR>', desc = 'Next Tab' },
    { '<leader>x', '<Cmd>BufferClose<CR>', desc = 'Close Tab' },
  },
}
