-- Remove netrw banner
vim.g.netrw_banner = 0

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers relative_time
vim.wo.relativenumber = true

-- Disable mouse mode
vim.o.mouse = ''

-- Disable swap
vim.opt.swapfile = false

-- Center cursors using scrolloff
vim.o.scrolloff = 999

-- Default indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Prevent line wrap
-- set tw=0
vim.cmd('set tw=0')
