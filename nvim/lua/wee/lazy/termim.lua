return {
  '2kabhishek/termim.nvim',
  -- These are the actual commands the plugin creates
  cmd = { 'Fterm', 'Sterm', 'Vterm', 'Tterm' },
  keys = {
    -- leader + to for a Horizontal Split (standard)
    { '<leader>to', '<cmd>Sterm<cr>', desc = 'Terminal Horizontal' },
    -- leader + tv for a Vertical Split
    { '<leader>tv', '<cmd>Vterm<cr>', desc = 'Terminal Vertical' },
    -- leader + tf for a Floating Terminal (very clean)
    { '<leader>tf', '<cmd>Fterm<cr>', desc = 'Terminal Float' },
  },
  config = function()
    -- This part ensures the terminal is clean (no numbers/clutter)
    vim.api.nvim_create_autocmd("TermOpen", {
      group = vim.api.nvim_create_augroup("TermimCleanup", { clear = true }),
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.foldcolumn = "0"
        vim.cmd("startinsert") -- Put you in typing mode immediately
      end,
    })
  end,
}
