return {
	-- Enables gcc and gc{motion} to comment out lines
	{
		'numToStr/Comment.nvim',
		keys = {
			{ 'gcc', mode = 'n', desc = 'Comment line' },
			{ 'gc', mode = { 'n', 'x' }, desc = 'Comment' },
		},
		opts = {}
	},
}
