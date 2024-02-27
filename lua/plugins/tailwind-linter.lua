return {
    'SushyDev/tailwind-linter.nvim',
    config = function ()
        require('tailwind-linter').setup({
            languages = { "html", "php", "phtml" },
        })
    end
}
