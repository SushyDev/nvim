return {
	{
		'williamboman/mason.nvim',
		cmd = { 'Mason', 'MasonUpdate' },
		opts = {},

	},
	{
		'mason-org/mason-lspconfig.nvim',
		branch = 'main',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'neovim/nvim-lspconfig', event = { 'BufReadPre', 'BufNewFile' } },
			{ 'williamboman/mason.nvim', cmd = { 'Mason', 'MasonUpdate' } },
		},
		config = function()
			local command_code_action = '<cmd>lua vim.lsp.buf.code_action()<cr>'
			local command_rename = '<cmd>lua vim.lsp.buf.rename()<cr>'
			local command_fmt = '<cmd>lua vim.lsp.buf.format({async = true})<cr>'

			vim.keymap.set('n', '<F4>', command_code_action { desc = 'Code action' })
			vim.keymap.set('n', '<F2>', command_rename { desc = 'Rename symbol' })
			vim.keymap.set({ 'n', 'x'}, '<F3>', command_fmt { desc = 'Format selection' })

			local mason_lspconfig = require('mason-lspconfig')
			mason_lspconfig.setup({
				automatic_enable = true,
			})

			require('plugins.lsp.config.gopls')
			require('plugins.lsp.config.html')
			require('plugins.lsp.config.vtsls')
			require('plugins.lsp.config.cssls')
			require('plugins.lsp.config.lua_ls')
			require('plugins.lsp.config.eslint')
			require('plugins.lsp.config.rust_analyzer')

			-- Alias filetypes

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "zsh",
				command = "setlocal filetype=bash",
			})

			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "dosbatch",
				command = "setlocal filetype=bash",
			})
		end
	},
}
