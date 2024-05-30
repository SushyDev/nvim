return {
    {
        'williamboman/mason.nvim',
        opts = {},

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

            lspconfig.util.on_setup = lspconfig.util.add_hook_before(lspconfig.util.on_setup, function(config)
                local cmd = config.cmd
                table.insert(cmd, 1, 'pkgx')
                config.cmd = cmd
            end)

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

            lspconfig.cssls.setup({
                filetypes = { 'html', 'css', 'scss', 'less', 'twig' },
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
        'mhartington/formatter.nvim',
        config = function()
            local formatter = require('formatter')

            formatter.setup({
                filetype = {
                    php = {
                        function()
                            return {
                                exe = "prettierd",
                                args = { vim.api.nvim_buf_get_name(0) },
                                stdin = true
                            }
                        end
                    },
                }
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    }
}
