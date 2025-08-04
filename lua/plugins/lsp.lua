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
			local function prefix_pkgx(config)
				local cmd = config.cmd
				table.insert(cmd, 1, 'pkgx')
				config.cmd = cmd
			end

			-- TODO: Implement lspzero default kepmaps into native nvim
			-- local function default_keymaps(_, bufnr)
			-- 	lsp_zero.default_keymaps({
			-- 		buffer = bufnr,
			-- 		preserve_mappings = false
			--
			-- 	})
			-- end
			-- lsp_zero.on_attach(default_keymaps)

			local command_code_action = '<cmd>lua vim.lsp.buf.code_action()<cr>'
			local command_fmt = '<cmd>lua vim.lsp.buf.format({async = true})<cr>'
			local command_rename = '<cmd>lua vim.lsp.buf.rename()<cr>'

			vim.keymap.set('n', '<F4>', command_code_action, { desc = 'Code action' })
			vim.keymap.set('n', '<F3>', command_fmt, { desc = 'Format file' })
			vim.keymap.set('x', '<F3>', command_fmt, { desc = 'Format selection' })
			vim.keymap.set('n', '<F2>', command_rename, { desc = 'Rename symbol' })

			-- local lspconfig = require('lspconfig')
			-- lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, prefix_pkgx)

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
