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
            handlers = {},
            ensure_installed = {},
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        config = function()
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
        end,
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')

            -- Basic debugging keymaps, feel free to change to your liking!
            vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
            vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
            vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
            vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
            vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
            dap.listeners.before.disconnect['dapui_config'] = dapui.close

            dap.configurations.php = dap.configurations.php or {}
            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003,
                    pathMappings = {
                        ["/var/www/html"] = "${workspaceFolder}"
                    }
                }
            }

            dap.adapters.delve = {
              type = 'server',
              port = '${port}',
              executable = {
                command = '/Users/sushy/go/bin/dlv',
                args = { 'dap', '-l', '127.0.0.1:${port}' },
              },
            }

            dap.configurations.go = dap.configurations.go or {}

            -- for each configuration, set dlvToolPath to point to the delve binary
            -- local dlv_path = "/Users/sushy/go/bin/dlv"
            -- for _, config in pairs(dap.configurations.go) do
            --     config.dlvToolPath = dlv_path
            -- end
            --
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
