-- Keymaps for better default experience
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Resizing ]]
vim.keymap.set('n', '<M-h>', '5<C-w><', { silent = true })
vim.keymap.set('n', '<M-j>', '5<C-w>-', { silent = true })
vim.keymap.set('n', '<M-k>', '5<C-w>+', { silent = true })
vim.keymap.set('n', '<M-l>', '5<C-w>>', { silent = true })
