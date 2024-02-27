-- Add indentation guides even on blank lines
-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`

return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  opts = {
    indent = {
      char = '┊',
    },
  },
}
