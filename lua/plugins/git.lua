-- Git plugins
require('gitsigns').setup({
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 0,
	},
})

-- vim-fugitive keymaps (plugin loaded via vim.pack; no setup() needed)
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
