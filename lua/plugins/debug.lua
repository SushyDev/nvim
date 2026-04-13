-- Debug: nvim-dap + dap-ui + mason-nvim-dap
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

-- Keymaps
vim.keymap.set('n', '<F55>', dapui.toggle, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<F49>', dap.step_into, { desc = 'Debug: Step Into' })    -- F1
vim.keymap.set('n', '<F50>', dap.step_over, { desc = 'Debug: Step Over' })    -- F2
vim.keymap.set('n', '<F51>', dap.step_out, { desc = 'Debug: Step Out' })      -- F3
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' }) -- F5
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
	dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Breakpoint' })

-- Auto open/close dapui
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
dap.listeners.before.disconnect['dapui_config'] = dapui.close

-- Go: delve adapter
dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = '/Users/sushy/go/bin/dlv', -- todo pkgx
		args = { 'dap', '-l', '127.0.0.1:${port}' },
	},
}

dap.configurations.go = dap.configurations.go or {}
table.insert(dap.configurations.go, {
	type = 'delve',
	name = 'Debug (entrypoint)',
	request = 'launch',
	mode = 'debug',
	program = '${workspaceFolder}',
})
table.insert(dap.configurations.go, {
	type = 'delve',
	name = 'Debug (Attach remote)',
	request = 'attach',
	mode = 'remote',
})
table.insert(dap.configurations.go, {
	type = 'delve',
	name = 'Debug (entrypoint + arg)',
	request = 'launch',
	mode = 'debug',
	program = '${workspaceFolder}',
	args = { './mnt' },
})

-- mason-nvim-dap: automatic adapter setup
require('mason-nvim-dap').setup({
	automatic_setup = true,
	handlers = {
		function(config)
			require('mason-nvim-dap').default_setup(config)
		end,

		php = function(package)
			for _, config in pairs(package.configurations) do
				config.port = 9003
				config.pathMappings = {
					['/var/www/html'] = '${workspaceFolder}',
				}
			end

			local command = package.adapters.command
			package.adapters.command = 'pkgx'
			package.adapters.args = { '+node', '--', command }

			require('mason-nvim-dap').default_setup(package)
		end,
	},
})
