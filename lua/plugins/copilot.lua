-- Copilot: inline ghost text suggestions only (no completion menu integration)
require('copilot').setup({
	suggestion = {
		auto_trigger = true,
		keymap = {
			accept = '<C-k>',
			accept_word = '<C-L>',
		},
	},
	copilot_node_command = 'node',
})
