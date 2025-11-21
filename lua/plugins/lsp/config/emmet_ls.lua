if vim.fn.executable('emmet-language-server') == 1 then
	local config = vim.lsp.config.emmet_language_server or {}
	local filetypes = config.filetypes or {}
	table.insert(filetypes, 'heex')

	vim.lsp.config("emmet_language_server", {
		filetypes = filetypes,
	})
end
