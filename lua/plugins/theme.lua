-- return {
-- 	'slugbyte/lackluster.nvim',
-- 	priority = 1000,
-- 	opts = {
-- 		colors = {
-- 			black = '#000000',
-- 			white = '#FFFFFF',
-- 			dark_gray = '#676E7B',
-- 		},
-- 		tweak_syntax = {
-- 			string = "#8A8A8A",
-- 			string_escape = "default",
-- 			comment = "#585858",
-- 			builtin = "default", -- builtin modules and functions
-- 			type = "#AC396D",
-- 			keyword = "#FFFFFF",
-- 			keyword_return = "default",
-- 			keyword_exception = "default",
-- 		},
-- 		tweak_background = {
-- 			normal = '#000000',
-- 		}
-- 	},
-- 	config = function(_, opts)
-- 		require('lackluster').setup(opts)
--
-- 		vim.cmd.colorscheme 'lackluster-mint'
--
-- 		vim.api.nvim_set_hl(0, 'StatusLine', {
-- 			bg = opts.colors.black,
-- 			fg = opts.colors.white,
-- 		})
--
-- 		vim.api.nvim_set_hl(0, 'StatusLineNC', {
-- 			bg = opts.colors.black,
-- 			fg = opts.colors.dark_gray,
-- 		})
-- 	end,
-- }

return {
	'olimorris/onedarkpro.nvim',
	priority = 1000,
	opts = {
		colors = {
			bg = '#000000',
			black = '#000000',
		}
	},
	config = function(_, opts)
		vim.cmd.colorscheme 'onedark_dark'

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
