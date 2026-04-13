-- LSP setup
-- Server configs live in lsp/*.lua (auto-loaded by Neovim via vim.lsp.enable)
-- mason-lspconfig handles automatic_enable for mason-installed servers

vim.cmd('packadd nvim-lspconfig')

require('mason').setup()

require('mason-lspconfig').setup({
	automatic_enable = true,
})

-- Conditionally enable servers that require executables not managed by mason
if vim.fn.executable('emmet-language-server') == 1 then
	vim.lsp.enable('emmet_language_server')
end

if vim.fn.executable('tailwindcss-language-server') == 1 then
	vim.lsp.enable('tailwindcss')
end

if vim.fn.executable('prettier') == 1 then
	vim.lsp.enable('prettier')
end

-- LSP keymaps
vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set({ 'n', 'x' }, '<F3>', function()
	vim.lsp.buf.format({ async = true })
end, { desc = 'Format selection' })

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp_keymaps', { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client and client:supports_method('textDocument/hover') then
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = 'Hover documentation' })
		end
	end,
})

-- Alias filetypes
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'zsh',
	command = 'setlocal filetype=bash',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'dosbatch',
	command = 'setlocal filetype=bash',
})
