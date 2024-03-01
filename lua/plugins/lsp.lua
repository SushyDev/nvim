return {
    {
        'williamboman/mason.nvim',
        opts = {},

    },
    {
        "zbirenbaum/copilot-cmp",
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
                    { name = "copilot" },
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
            -- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({
                    buffer = bufnr,
                    preserve_mappings = false

                })
            end)

            require('mason-lspconfig').setup({
                handlers = {
                    lsp_zero.default_setup,
                }
            })

            -- require('lspconfig').phpactor.setup({
            --     capabilities = lsp_capabilities,
            --     filetypes = { 'php' },
            -- })

            require('lspconfig').html.setup({
                -- capabilities = lsp_capabilities,
                filetypes = { 'html', 'twig', 'php' },
            })

            require('lspconfig').tsserver.setup({
                -- capabilities = lsp_capabilities,
                filetypes = { 'javascript', 'typescript', 'php' },
            })

            require('lspconfig').lua_ls.setup({
                -- capabilities = lsp_capabilities,
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
