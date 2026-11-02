-- Sidebar on top of the builtin directory browser (:help dir, Neovim 0.13+).
-- <leader>e toggles a fixed-width listing on the left of the tab.
-- In the sidebar, <CR> on a file opens it in the window you came from;
-- directories, - and R work as in any directory buffer, but stay in the sidebar.

local M = {}

local width = 35

local function find()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.w[win].sidebar then return win end
	end
end

-- A regular window (not floating, not the sidebar) showing a normal buffer
local function is_editor(win)
	return win ~= 0
		and not vim.w[win].sidebar
		and vim.api.nvim_win_get_config(win).relative == ''
		and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == ''
end

-- Where files picked in the sidebar open: the previous window, else any editor window
local function editor_win()
	local prev = vim.fn.win_getid(vim.fn.winnr('#'))
	if is_editor(prev) then return prev end
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if is_editor(win) then return win end
	end
end

local style = {
	winfixwidth = true,
	winpinned = true, -- survives :only / <C-w>o
	number = false,
	relativenumber = false,
	signcolumn = 'no',
	foldcolumn = '0',
	list = false,
	wrap = false,
	cursorline = true,
}

-- :setlocal only, so the window's global values stay the user's defaults
local function apply_style(win)
	for name, value in pairs(style) do
		vim.wo[win][0][name] = value
	end
end

-- Windows split off the sidebar copy its options; reset them to the global values
local function new_editor_win(enter, buf)
	local win = vim.api.nvim_open_win(buf, enter, { split = 'right', win = -1 })
	vim.api.nvim_win_call(win, function()
		for name in pairs(style) do
			vim.cmd.setlocal(name .. '<')
		end
	end)
	vim.cmd.wincmd('=')
	return win
end

---@param dir_open function the dir plugin's own <Plug>(nvim-dir-open)
local function open_entry(dir_open)
	local line = vim.api.nvim_get_current_line()
	if not vim.w.sidebar or line == '' or line:sub(-1) == '/' then
		return dir_open()
	end

	local path = vim.fs.joinpath(vim.api.nvim_buf_get_name(0), line)
	local win = editor_win()
	if win then
		vim.api.nvim_set_current_win(win)
	else
		new_editor_win(true, 0)
	end
	vim.cmd.edit(vim.fn.fnameescape(path))
end

--- Open (or focus) the sidebar on {dir}, with the cursor on {select} if given.
---@param dir string
---@param select? string entry name to put the cursor on
function M.open(dir, select)
	local win = find()
	if win then
		vim.api.nvim_set_current_win(win)
	else
		win = vim.api.nvim_open_win(0, true, { split = 'left', win = -1, width = width })
		vim.w[win].sidebar = true
		apply_style(win)
	end
	vim.cmd.edit({ args = { dir }, mods = { keepalt = true }, magic = { file = false } })
	if select then
		vim.fn.search([[\V\^]] .. vim.fn.escape(select, [[\]]) .. [[\$]], 'cw')
	end
end

function M.close()
	local win = find()
	if not win then return end
	-- Can't close the last window: give the file a window first
	if not editor_win() then
		new_editor_win(false, vim.api.nvim_create_buf(true, false))
	end
	vim.api.nvim_win_close(win, false)
end

--- Close the sidebar, or open it on the current file's directory.
function M.toggle()
	if find() then return M.close() end

	local name = vim.api.nvim_buf_get_name(0)
	if vim.bo.filetype == 'directory' then
		M.open(name)
	elseif name ~= '' and vim.bo.buftype == '' then
		M.open(vim.fs.dirname(name), vim.fs.basename(name))
	else
		M.open(vim.fn.getcwd())
	end
end

local group = vim.api.nvim_create_augroup('sidebar', { clear = true })

-- <CR> in directory buffers maps to <Plug>(nvim-dir-open), which the dir plugin
-- defines after init.lua runs; wrap it once plugins are loaded.
vim.api.nvim_create_autocmd('VimEnter', {
	group = group,
	once = true,
	callback = function()
		local dir_open = vim.fn.maparg('<Plug>(nvim-dir-open)', 'n', false, true).callback
		if not dir_open then return end
		vim.keymap.set('n', '<Plug>(nvim-dir-open)', function() open_entry(dir_open) end, {
			silent = true,
			desc = 'Open directory entry (files from the sidebar open in the editor window)',
		})
	end,
})

-- Window options are remembered per buffer; re-apply them to each listing shown in the sidebar
vim.api.nvim_create_autocmd('BufWinEnter', {
	group = group,
	callback = function()
		local win = vim.api.nvim_get_current_win()
		if vim.w[win].sidebar then apply_style(win) end
	end,
})

-- Quitting the last editor window also closes the sidebar, so :q exits Neovim
vim.api.nvim_create_autocmd('QuitPre', {
	group = group,
	callback = function()
		local cur = vim.api.nvim_get_current_win()
		local sidebar
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if win ~= cur and vim.api.nvim_win_get_config(win).relative == '' then
				if not vim.w[win].sidebar then return end
				sidebar = win
			end
		end
		if sidebar then vim.api.nvim_win_close(sidebar, false) end
	end,
})

vim.keymap.set('n', '<leader>e', M.toggle, { desc = 'Toggle file sidebar' })

return M
