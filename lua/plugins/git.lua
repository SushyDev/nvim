return {
	{
		'tpope/vim-fugitive',
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 0,
			},
		}
	},
}
