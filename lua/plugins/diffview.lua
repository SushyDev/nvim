return {
  'sindrets/diffview.nvim',
  config = function()
    local diffview = require 'diffview'
    diffview.setup {
      use_icons = false,
    }

    vim.keymap.set('n', '<leader>dv', function()
      if vim.fn.tabpagenr('$') > 1 then
        vim.cmd('tabclose')
      else
        diffview.open({})
      end
    end, { desc = 'Open [D]iff[V]iew' })
  end
}
