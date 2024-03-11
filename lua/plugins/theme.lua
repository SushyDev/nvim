return {
    'sekke276/dark_flat.nvim',
    priority = 1000,
    opts = {
        colors = {
            bg = '#000000',
            black = '#000000',
        }
    },
    config = function(_, opts)
        require('dark_flat').setup(opts)

        vim.cmd.colorscheme 'dark_flat'
    end,
}
