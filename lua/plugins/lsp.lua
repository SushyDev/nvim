return {
	{
		'williamboman/mason.nvim',
		opts = {},

	},
	{
		'mason-org/mason-lspconfig.nvim',
		branch = 'v3.x',
		dependencies = {
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
		},
		config = function()
			local lspconfig = require('lspconfig')
			local mason_lspconfig = require('mason-lspconfig')

			local function prefix_pkgx(config)
				local cmd = config.cmd
				-- table.insert(cmd, 1, 'pkgx')
				config.cmd = cmd
			end

			-- TODO: Implement lspzero default kepmaps into native nvim
			-- local function default_keymaps(_, bufnr)
			-- 	lsp_zero.default_keymaps({
			-- 		buffer = bufnr,
			-- 		preserve_mappings = false
			--
			-- 	})
			-- end
			-- lsp_zero.on_attach(default_keymaps)

			vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
				{ desc = 'Format file' })
			vim.keymap.set('x', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
				{ desc = 'Format selection' })
			vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol' })

			lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, prefix_pkgx)

			mason_lspconfig.setup({
				automatic_enable = true,
			})

			vim.lsp.config("html", {
				filetypes = { 'html', 'twig', 'php', 'templ' },
			})

			vim.lsp.config("vtsls", {
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					vtsls = { tsserver = { globalPlugins = {} } },
				},
				before_init = function(_, config)
					table.insert(config.settings.vtsls.tsserver.globalPlugins, {
						name = "@vue/typescript-plugin",
						location =
						"$HOME/.local/lib/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					})
				end,
			})

			vim.lsp.config("cssls", {
				filetypes = { 'html', 'css', 'scss', 'less', 'twig' },
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							}
						}
					}
				}
			})

			vim.lsp.config("eslint", {
				cmd = {
					"vscode-eslint-language-server",
					"--stdio",
				},
			})
		end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require('cmp')
			local bordered = cmp.config.window.bordered()

			cmp.setup({
				window = {
					completion = bordered,
					documentation = bordered,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-e>'] = cmp.mapping.abort(),
					['<C-s>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "copilot" }, -- if copilot-cmp is installed
					{ name = "nvim_lsp" },
				}
			})
		end
	},
	{
		'stevearc/conform.nvim',
		config = function()
			local conform = require('conform')

			conform.setup({
				formatters_by_ft = {
					go = { { "gofmt" } },
				}
			})
		end
	},
	{
		'numToStr/Comment.nvim',
		opts = {}
	},
	-- {
	-- 	'mfussenegger/nvim-lint',
	-- 	config = function()
	-- 		vim.env.ESLINT_D_PPID = vim.fn.getpid()
	--
	-- 		local lint = require('lint')
	--
	-- 		lint.linters_by_ft = {
	-- 			lua = { 'luacheck' },
	-- 			javascript = { 'eslint_d' },
	-- 			typescript = { 'eslint_d' },
	-- 			html = { 'htmlhint' },
	-- 			css = { 'stylelint' },
	-- 		}
	--
	-- 		vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
	-- 			pattern = { '*' },
	-- 			callback = function()
	-- 				lint.try_lint()
	-- 			end,
	-- 		})
	-- 	end
	-- }
}
