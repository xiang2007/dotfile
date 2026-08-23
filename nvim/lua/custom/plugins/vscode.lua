-- VS Code-style keymaps on top of the kickstart defaults

local builtin = require 'telescope.builtin'

-- File finding (VS Code Ctrl+P)
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files (VS Code style)' })

-- Search across all files in the project (VS Code Ctrl+Shift+F)
vim.keymap.set('n', '<C-S-f>', builtin.live_grep, { desc = 'Live grep in files (VS Code style)' })

-- "Command palette": pick any Telescope action (VS Code Ctrl+Shift+P)
vim.keymap.set('n', '<C-S-p>', builtin.builtin, { desc = 'Telescope command palette (VS Code style)' })

-- File explorer sidebar (VS Code Ctrl+Shift+E)
vim.keymap.set('n', '<C-S-e>', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer (VS Code style)' })

-- LSP shortcuts matching VS Code (F2 rename, F12 go to definition)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('vscode-lsp-keymaps', { clear = true }),
  callback = function(ev)
    local map = function(keys, fn, desc)
      vim.keymap.set('n', keys, fn, { buffer = ev.buf, desc = 'LSP: ' .. desc })
    end
    map('<F2>', vim.lsp.buf.rename, '[F2] Rename symbol')
    map('<F12>', vim.lsp.buf.definition, '[F12] Go to definition')
  end,
})

-- Toggle line/selection comments (VS Code Ctrl+/)
vim.keymap.set('n', '<C-/>', 'gcc', { desc = 'Toggle comment on line' })
vim.keymap.set('x', '<C-/>', 'gc', { desc = 'Toggle comment on selection' })
