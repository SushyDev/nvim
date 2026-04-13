-- prettier: extend default filetypes with heex
-- Conditionally enabled in plugins/lsp.lua based on executable availability
return {
	filetypes = {
		'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
		'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml', 'markdown',
		'graphql', 'vue', 'svelte', 'heex',
	},
}
