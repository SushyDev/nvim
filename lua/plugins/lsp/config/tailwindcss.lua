if vim.fn.executable('tailwindcss-language-server') == 1 then
	local config = vim.lsp.config.tailwindcss or {}
	local filetypes = config.filetypes or {}
	table.insert(filetypes, 'heex')

	vim.lsp.config("tailwindcss", {
		filetypes = filetypes,
	})
end
