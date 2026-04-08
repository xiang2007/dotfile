-- Navigation & UI
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true       -- Highlights the line your cursor is on
vim.opt.scrolloff = 8           -- Keeps 8 lines above/below cursor when scrolling
vim.opt.mouse = 'a'             -- Enable mouse for Barbar tabs and scrolling
vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true

-- Modern Indentation (2-space soft tabs)
-- This is standard for JS, Lua, HTML, and JSON
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true        -- Turn tabs into spaces for better compatibility
vim.opt.smartindent = true

-- Search Behavior
vim.opt.hlsearch = false        -- Don't keep previous search highlighted
vim.opt.incsearch = true        -- Show matches as you type
vim.opt.ignorecase = true       -- Case insensitive search...
vim.opt.smartcase = true        -- ...unless you use a Capital letter

-- The "Clean" Whitespace
vim.opt.list = true
vim.opt.listchars = {
    tab = '  ',                 -- Make tabs invisible but aligned
    trail = '·',                -- Only show trailing spaces (the "bad" ones)
    nbsp = '␣',
}

vim.opt.updatetime = 50         -- Faster response for undo-glow and diagnostics
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true         -- Persistent undo (so undo-glow works after restart)

vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "?*",
    command = "silent! mkview",
})

vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
        vim.cmd("bdelete!")
    end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "?*", 
    callback = function()
        if vim.bo.buftype == "" then
            pcall(vim.cmd, "silent! mkview")
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd("startinsert")
    end,
})
