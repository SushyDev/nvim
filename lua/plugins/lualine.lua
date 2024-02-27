-- Set lualine as statusline
-- See `:help lualine.txt`
local colors = {
  black        = '#000000',
  white        = '#ffffff',
  gray         = '#a89984',
  pink         = '#EF8DF9',
  blue         = '#61D4FA',
  orange       = '#EC6A2C',
}

local vapor = {
  normal = {
    a = { bg = colors.black, fg = colors.pink },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  },
  insert = {
    a = { bg = colors.black, fg = colors.blue },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  },
  visual = {
    a = { bg = colors.black, fg = colors.orange },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  },
  replace = {
    a = { bg = colors.black, fg = colors.orange },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  },
  command = {
    a = { bg = colors.black, fg = colors.blue },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  },
  inactive = {
    a = { bg = colors.black, fg = colors.gray },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.white }
  }
}

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = vapor,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'netrw' },
        filename = { path = 1 },
        fmt = string.lower
      },
      sections = {
        lualine_c = { { 'filename', path = 1 } }
      }
    }
  end
}
