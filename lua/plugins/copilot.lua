return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			suggestion = {
				auto_trigger = true,
				keymap = {
					accept = "<C-k>",
					accept_word = "<C-L>",
				}
			},
			copilot_node_command = 'node',
		},
	},
}
