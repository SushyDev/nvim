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
            copilot_node_command = 'node',
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        opts = {},
    },
}
