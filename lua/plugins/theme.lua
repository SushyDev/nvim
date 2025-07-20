return {
	'sekke276/dark_flat.nvim',
	priority = 1000,
	opts = {
		colors = {
			bg = '#000000',
			black = '#000000',
		}
	},
	config = function(_, opts)
		require('dark_flat').setup(opts)

		vim.cmd.colorscheme 'dark_flat'

		vim.api.nvim_set_hl(0, 'StatusLine', {
			bg = opts.colors.black,
			fg = opts.colors.white,
		})

		vim.api.nvim_set_hl(0, 'StatusLineNC', {
			bg = opts.colors.black,
			fg = "#676E7B",
		})
	end,
}
