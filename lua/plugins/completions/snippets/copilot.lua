local copilot = require("copilot.suggestion")

local function hide_copilot()
	copilot.dismiss()
	vim.b.copilot_suggestion_hidden = true
end

local function show_copilot()
	vim.b.copilot_suggestion_hidden = false
end

local function enable_copilot_keymaps()
	if vim.b.copilot_suggestion_hidden then
		return
	end

	vim.keymap.set('i', '<C-s>', function()
		copilot.accept()
	end, { buffer = 0, desc = 'Accept Copilot suggestion' })

	vim.keymap.set('i', '<C-L>', function()
		copilot.accept_word()
	end, { buffer = 0, desc = 'Accept Copilot word' })
end

local function disable_copilot_keymaps()
	vim.keymap.del('i', '<C-s>', { buffer = 0 })
	vim.keymap.del('i', '<C-L>', { buffer = 0 })
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'BlinkCmpMenuOpen',
	callback = function()
		hide_copilot()
	end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'BlinkCmpMenuClose',
	callback = function()
		show_copilot()
	end,
})
