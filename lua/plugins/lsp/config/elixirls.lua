vim.lsp.config("elixirls", {
	settings = {
		elixirLS = {
			dialyzerEnabled = true,
			fetchDeps = false,
		}
	},
})
