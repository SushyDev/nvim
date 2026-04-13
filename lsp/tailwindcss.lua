-- tailwindcss: extend default filetypes with heex
-- Conditionally enabled in plugins/lsp.lua based on executable availability
return {
	filetypes = {
		'html', 'css', 'scss', 'sass', 'less', 'javascriptreact', 'typescriptreact',
		'vue', 'svelte', 'astro', 'twig', 'blade', 'heex',
	},
}
