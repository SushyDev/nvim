if vim.fn.executable('prettier') == 1 then
	local config = vim.lsp.config.prettier or {}
	local filetypes = config.filetypes or {}
	table.insert(filetypes, 'heex')

	vim.lsp.config("prettier", {
		filetypes = filetypes,
	})
end
