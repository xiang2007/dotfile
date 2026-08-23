-- Personal quality-of-life tweaks (kept separate from upstream kickstart)

-- Relative line numbers (absolute number still shown on the current line)
vim.o.relativenumber = true

-- Keep a few columns visible when scrolling horizontally
vim.o.sidescrolloff = 5

-- Quick save: <leader>w or Ctrl-s (works from insert mode too)
vim.keymap.set('n', '<leader>w', function() vim.cmd.write() end, { desc = '[W]rite file' })
vim.keymap.set({ 'n', 'i' }, '<C-s>', function() vim.cmd.write() end, { desc = 'Write file' })

-- Quickfix list navigation (handy after diagnostics or grep results)
vim.keymap.set('n', ']q', function() vim.cmd.cnext() end, { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', function() vim.cmd.cprevious() end, { desc = 'Previous quickfix item' })

-- Toggle relative line numbers on the fly
vim.keymap.set('n', '<leader>ur', function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = '[U]se [R]elative line numbers' })

-- Open this keymap reference from anywhere
vim.keymap.set('n', '<leader>?', function()
  vim.cmd.edit(vim.fn.stdpath('config') .. '/KEYMAPS.md')
end, { desc = 'Open [K]eymap reference' })
