-- emmet_language_server: extend default filetypes with heex
-- Conditionally enabled in plugins/lsp.lua based on executable availability
return {
	filetypes = {
		'html', 'css', 'scss', 'sass', 'less', 'javascriptreact', 'typescriptreact',
		'twig', 'blade', 'heex',
	},
}
