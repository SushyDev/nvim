return {
	{
		'williamboman/mason.nvim',
		opts = {},

	},
	{
		'mason-org/mason-lspconfig.nvim',
		branch = 'main',
		dependencies = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
		},
		config = function()
			vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })
			vim.keymap.set({ 'n', 'x'}, '<F3>', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format selection' })
			vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })

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
		end
	},
}
