return {
	'glacambre/firenvim',
	build = ":call firenvim#install(0)",
	config = function(_, opts)
		vim.g.firenvim_config = {
			globalSettings = {
				alt = "all",
				ignoreKeys = {
					all = {
						'D-v',
					},
				},
			},
			localSettings = {
				[".*"] = {
					cmdline  = "neovim",
					content  = "text",
					priority = 0,
					selector = "textarea",
					takeover = "always"
				},
				['https://aistudio.google.com'] = {
					selector = "textarea",
					takeover = "never"
				},
				['https://www.google.com'] = {
					selector = "textarea",
					takeover = "never"
				},
				['https://preview.control-center.conneqt.io'] = {
					selector = "textarea",
					takeover = "never"
				},
				['https://control-center.conneqt.io'] = {
					selector = "textarea",
					takeover = "never"
				},
			}
		}

		if vim.g.started_by_firenvim == true then
			vim.o.laststatus = 0

			vim.keymap.set('n', '<D-v>', '"+p')
			vim.keymap.set('c', '<D-v>', '<C-r>+')
		end
	end,
}
