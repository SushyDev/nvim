-- Interface
vim.opt.relativenumber = true -- Make line numbers relative_time
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.opt.hlsearch = true -- Set highlight on search
vim.opt.showmatch = true -- Show matching brackets
vim.opt.cmdheight = 0 -- Hide command line
-- vim.opt.cursorline = true -- Highlight the current line

-- File handling
vim.opt.backup = false -- Disable backup
vim.opt.writebackup = false -- Disable write backup
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/nvim-undo" -- Set undo directory
vim.opt.autoread = true -- Automatically read files when changed outside of Vim
vim.opt.autowrite = false -- Disable auto write on quit

-- Search
vim.opt.smartindent = true

-- Whilespace characters
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = "space:·,tab:→ ,eol:↴"

-- Default indentation
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.autoindent = true

-- Miscellaneous
vim.g.netrw_banner = 0 -- Remove netrw banner
vim.opt.mouse = '' -- Disable mouse mode
vim.opt.swapfile = false -- Disable swap
vim.opt.scrolloff = 999 -- Center cursors using scrolloff
vim.opt.wrap = false -- Disable line wrap
