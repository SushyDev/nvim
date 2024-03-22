-- local function get_path()
--     local handle = io.popen("pkgx +node@20 +dlv -- which node")
--     if not handle then
--         return "/usr/bin/node"
--     end
--
--     local result = handle:read("*a")
--     handle:close()
--
--     return result:match( "^%s*(.-)%s*$" )
-- end

return {
    {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
            automatic_setup = true,
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
                php = function(config)
                    for _, cnfg in pairs(config.configurations) do
                        cnfg.port = 9003
                        cnfg.pathMappings = {
                            ["/var/www/html"] = "${workspaceFolder}"
                        }
                    end

                    require('mason-nvim-dap').default_setup(config)
                end
            },
        },
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup({
                icons = {
                    expanded = '▾',
                    collapsed = '▸',
                    open = '▾',
                    close = '▸',
                },
                controls = {
                    enabled = false,
                },
            })

            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

            -- Basic debugging keymaps, feel free to change to your liking!
            vim.keymap.set('n', '<F49>', dap.step_into, { desc = 'Debug: Step Into' })     -- F1
            vim.keymap.set('n', '<F50>', dap.step_over, { desc = 'Debug: Step Over' })     -- F2
            vim.keymap.set('n', '<F51>', dap.step_out, { desc = 'Debug: Step Out' })       -- F3
            vim.keymap.set('n', '<F53>', dap.continue, { desc = 'Debug: Start/Continue' }) -- F5
            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Set Breakpoint' })

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
            dap.listeners.before.disconnect['dapui_config'] = dapui.close

            dap.adapters.delve = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = '/Users/sushy/go/bin/dlv',
                    args = { 'dap', '-l', '127.0.0.1:${port}' },
                },
            }

            -- for each configuration, set dlvToolPath to point to the delve binary
            -- local dlv_path = "/Users/sushy/go/bin/dlv"
            -- for _, config in pairs(dap.configurations.go) do
            --     config.dlvToolPath = dlv_path
            -- end

            dap.configurations.go = dap.configurations.go or {}
            table.insert(dap.configurations.go, {
                type = "delve",
                name = "Debug (entrypoint)",
                request = "launch",
                mode = "debug",
                program = "${workspaceFolder}",
            })
            table.insert(dap.configurations.go, {
                type = "delve",
                name = "Attach remote",
                request = "attach",
                mode = "remote",
            })
        end,
    }
}
