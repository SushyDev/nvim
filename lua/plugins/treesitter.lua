-- Treesitter setup
-- highlight and indent are handled by Neovim's built-in treesitter integration
-- nvim-treesitter in the new API only manages parser installation

-- Enable built-in treesitter highlight and indent for all filetypes
vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('treesitter_enable', { clear = true }),
	callback = function(ev)
		local ok = pcall(vim.treesitter.start, ev.buf)
		if ok then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

-- treesitter-context
require('treesitter-context').setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = 'outer',
	mode = 'cursor',
	separator = nil,
	zindex = 20,
	on_attach = nil,
})

-- nvim-treesitter-textobjects: setup (behaviour config)
require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

-- textobjects: select keymaps
local sel = require('nvim-treesitter-textobjects.select')
vim.keymap.set({ 'x', 'o' }, 'aa', function() sel.select_textobject('@parameter.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ia', function() sel.select_textobject('@parameter.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'af', function() sel.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() sel.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() sel.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() sel.select_textobject('@class.inner', 'textobjects') end)

-- textobjects: move keymaps
local move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

-- textobjects: swap keymaps
local swap = require('nvim-treesitter-textobjects.swap')
vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner') end)
vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner') end)
