-- Fuzzy Finder (files, lsp, etc)
-- See `:help telescope.builtin`

return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
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
      pcall(require('telescope').load_extension('fzf'))

      -- Enable telescope tailwindcss (tailiscope)
      pcall(require('telescope').load_extension('tailiscope'))

      -- Keymaps
      vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
      vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

      local all_files = { additional_args = { '-uu' } }
      vim.keymap.set('n', '<leader>sag', function()
        require('telescope.builtin').live_grep(all_files)
      end, { desc = '[S]earch [A]ll [G]rep' })

      -- Search for files in the vendor directory
      local vendor_files = { search_dirs = { 'vendor' } }
      vim.keymap.set('n', '<leader>svf', function()
        require('telescope.builtin').find_files(vendor_files)
      end, { desc = '[S]earch [V]endor [F]iles' })

      -- Search for files in the vendor directory
      local vendor_grep = { search_dirs = { 'vendor' }, additional_args = { '-uu' } }
      vim.keymap.set('n', '<leader>svg', function()
        require('telescope.builtin').live_grep(vendor_grep)
      end, { desc = '[S]earch [V]endor [G]rep' })

      -- Wrap results for all file types except help
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function(args)
          -- if args.data.filetype ~= "help" then
          --   vim.wo.number = true
          -- elseif args.data.bufname:match("*.csv") then
          --   vim.wo.wrap = false
          -- end
          vim.wo.wrap = true
        end,
      })
    end,
  }
}
