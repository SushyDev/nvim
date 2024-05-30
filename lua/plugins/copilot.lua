return {
    {
        'zbirenbaum/copilot.lua',
        opts = {
            suggestion = {
                auto_trigger = true,
                keymap = {
                    accept = "<C-K>",
                    accept_word = "<C-L>",
                }
            },
            copilot_node_command = 'pkgx',
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        opts = {},
    },
}
