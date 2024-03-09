local function get_path()
    local handle = io.popen("pkgx +node@20 -- which node")
    if not handle then
        return "/usr/bin/node"
    end

    local result = handle:read("*a")
    handle:close()

    return result:match( "^%s*(.-)%s*$" )
end

return {
    'zbirenbaum/copilot.lua',
    opts = {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = "<C-K>",
                accept_word = "<C-L>",
            }
        },
        copilot_node_command = get_path(),
    },
    {
        "zbirenbaum/copilot-cmp",
        opts = {},
    },
}
