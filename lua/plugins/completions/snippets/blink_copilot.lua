local copilot = require("copilot.suggestion")

local function hide_copilot()
	copilot.dismiss()
	vim.b.copilot_suggestion_hidden = true
end

local function show_copilot()
	vim.b.copilot_suggestion_hidden = false
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'BlinkCmpMenuOpen',
	callback = hide_copilot,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'BlinkCmpMenuClose',
	callback = show_copilot,
})
