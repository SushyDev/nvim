vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				disabled = { "unlinked-file" },
			},
		}
	}
})
