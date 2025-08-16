return {
	{
		'tpope/vim-fugitive',
		cmd = { 'Git', 'G', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit', 'Gread', 'Gcommit', 'Gpush', 'Gpull' },
		keys = {
			{ '<leader>gs', ':Git<CR>', desc = 'Git status' },
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 0,
			},
		},
	},
}
