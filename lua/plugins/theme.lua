return {
	'maxmx03/fluoromachine.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		local opts = {
			glow = false,
			theme = 'fluoromachine',
			transparent = true,
			colors = {
				bg = '#000000',
				black = '#000000',
			}
		}

		require('fluoromachine').setup(opts)

		vim.cmd.colorscheme('fluoromachine')

		vim.api.nvim_set_hl(0, 'StatusLine', {
			bg = opts.colors.black,
		})

		vim.api.nvim_set_hl(0, 'StatusLineNC', {
			bg = opts.colors.black,
		})

		vim.api.nvim_set_hl(0, 'TreesitterContext', {
			bg = opts.colors.black,
		})
	end
}
