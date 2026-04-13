-- Native package manager (Neovim 0.12+)
-- load = true: run packadd for all plugins immediately so require() works below
vim.pack.add({
	-- Mason: tool installer
	{ src = 'https://github.com/williamboman/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- Git
	{ src = 'https://github.com/tpope/vim-fugitive' },
	{ src = 'https://github.com/lewis6991/gitsigns.nvim' },

	-- Telescope
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },

	-- Theme
	{ src = 'https://github.com/maxmx03/fluoromachine.nvim' },

	-- Treesitter
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },

	-- Copilot (inline ghost text only)
	{ src = 'https://github.com/zbirenbaum/copilot.lua' },

	-- Debug
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/rcarriga/nvim-dap-ui' },
	{ src = 'https://github.com/nvim-neotest/nvim-nio' },
	{ src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },

	-- UI / Navigation
	{ src = 'https://github.com/aserowy/tmux.nvim' },
	{ src = 'https://github.com/folke/which-key.nvim' },
}, { load = true })

-- Run plugin setup files
require('plugins.theme')
require('plugins.git')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.copilot')
require('plugins.lsp')
require('plugins.debug')
require('plugins.tmux')
require('plugins.whichkey')
