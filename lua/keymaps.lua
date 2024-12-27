-- Resizing
vim.keymap.set('n', '<M-h>', '5<C-w><', { silent = true })
vim.keymap.set('n', '<M-j>', '5<C-w>-', { silent = true })
vim.keymap.set('n', '<M-k>', '5<C-w>+', { silent = true })
vim.keymap.set('n', '<M-l>', '5<C-w>>', { silent = true })

-- Preview hunk
vim.keymap.set('n', '<S-l>', ':Gitsigns preview_hunk_inline<CR>')

-- Visual move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Open diagnostics
vim.keymap.set('n', '<S-h>', function()
    vim.diagnostic.open_float({ border = 'rounded' })
end, { desc = 'Open diag' })

-- Open quickfix
vim.keymap.set('n', '<S-q>', function()
    vim.cmd('copen')
end, { desc = 'Open quickfix' })
