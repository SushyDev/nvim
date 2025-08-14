vim.lsp.config("vtsls", {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {},
			},
		},
	},
	before_init = function(_, config)
		if require('mason-registry').is_installed('vue-language-server') then
			table.insert(config.settings.vtsls.tsserver.globalPlugins, {
				name = "@vue/typescript-plugin",
				location = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
				languages = { "vue" },
				configNamespace = "typescript",
				enableForWorkspaceTypeScriptVersions = true,
			})
		end
	end,
})
