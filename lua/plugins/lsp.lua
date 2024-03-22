return {
    {
        'williamboman/mason.nvim',
        opts = {},

    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
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
                    { name = "buffer" },
                }
            })
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            local lspconfig = require('lspconfig')
            local mason_lspconfig = require('mason-lspconfig')

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false

                })
            end)

            mason_lspconfig.setup({
                handlers = {
                    lsp_zero.default_setup,
                }
            })

            lspconfig.html.setup({
                filetypes = { 'html', 'twig', 'php', 'templ' },
            })

            lspconfig.tsserver.setup({
                filetypes = { 'javascript', 'typescript' },
            })

            lspconfig.lua_ls.setup({
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
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    }
}
