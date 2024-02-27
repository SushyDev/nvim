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
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                handlers = {
                    lsp_zero.default_setup,
                }
            })

            require('lspconfig').html.setup({
                capabilities = lsp_capabilities,
                filetypes = {'html', 'twig', 'php'},
            })

            require('lspconfig').tsserver.setup({
                capabilities = lsp_capabilities,
                filetypes = {'javascript', 'typescript', 'php'},
            })

            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = {'vim'},
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
