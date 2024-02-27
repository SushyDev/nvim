local function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

local function get_path()
  local handle = io.popen("pkgx +node@20 -- which node")
  if not handle then
    return nil
  end

  local result = handle:read("*a")
  handle:close()
  return all_trim(result)
end

return {
  'zbirenbaum/copilot.lua',
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-L>"
      }
    },
    copilot_node_command = get_path(),
  }
}
