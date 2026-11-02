local function modulePath()
	local path = vim.fn.expand("%:h")
	local match = nil

	match = string.match(path, ".*[A-Z][a-z]*_?[A-Z][a-z]*")
	if match then
		return match
	end

	match = string.match(path, ".*app/design/.-/")
	if match then
		return match
	end

	match = string.match(path, ".*app/code/.-/")
	if match then
		return match
	end

	return nil
end

-- :Tree [dir] opens the sidebar on {dir}, or on the current file's module
vim.api.nvim_create_user_command('Tree', function(opts)
	local path = opts.args ~= '' and opts.args or modulePath()
	if path == nil then
		print("No match found")
		return
	end

	require('sidebar').open(path)
end, { nargs = '?', complete = 'dir', desc = 'Open sidebar on module directory' })
