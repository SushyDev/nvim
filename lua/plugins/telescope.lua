return {
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = require('telescope')
			local telescope_builtin = require('telescope.builtin')

			telescope.setup {
				defaults = {
					wrap_results = true,
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = false,
						},
					},
					cache_picker = {
						num_pickers = 32,
					},
					path_display = {
						'truncate',
					},
				},
			}

			-- Enable telescope fzf native, if installed
			telescope.load_extension('fzf')

			-- Enable telescope tailwindcss (tailiscope)
			-- pcall(require('telescope').load_extension('tailiscope'))

			-- Keymaps
			vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
			vim.keymap.set('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })

			vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, { desc = 'Search [G]it [F]iles' })
			vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
			vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
			vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

			local all_files = { additional_args = { '-uu' } }
			vim.keymap.set('n', '<leader>sag', function()
				telescope_builtin.live_grep(all_files)
			end, { desc = '[S]earch [A]ll [G]rep' })

			-- Search for files in the vendor directory
			-- !vendor/**
			local vendor_files = { search_dirs = { 'vendor' }, no_ignore = true }
			vim.keymap.set('n', '<leader>svf', function()
				telescope_builtin.find_files(vendor_files)
			end, { desc = '[S]earch [V]endor [F]iles' })

			-- Search for files in the vendor directory
			local vendor_grep = { search_dirs = { 'vendor' }, additional_args = { '-uu' } }
			vim.keymap.set('n', '<leader>svg', function()
				telescope_builtin.live_grep(vendor_grep)
			end, { desc = '[S]earch [V]endor [G]rep' })
		end,
	}
}
