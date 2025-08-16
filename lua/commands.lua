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

function Tree()
	local path = modulePath()
	if path == nil then
		print("No match found")
		return
	end

	vim.cmd("silent Lex " .. path)
	vim.cmd("vertical resize 50")

	-- set listing style to tree
	vim.cmd("normal i")
	vim.cmd("normal i")
	vim.cmd("normal i")
end

vim.cmd([[command! -nargs=0 Tree lua Tree()]])
