-- HEEx editing: Emmet on <Tab>, LSP in the completion popup, no indent jumps on '>'.
-- Emmet only fires inside HEEx (a .heex file, or inside ~H""" in an .ex file),
-- so <Tab> after `def` in Elixir code stays a normal <Tab>.

local emmet_dir = vim.fn.stdpath('data')
	.. '/mason/packages/emmet-language-server/node_modules/@olrtg/emmet-language-server/node_modules/emmet'

-- Reads {line, col} on stdin, prints {start, end, snippet} or nothing.
local emmet_js = [[
const e = require(process.argv[1]);
const expand = e.default || e;
const { line, col } = JSON.parse(require('fs').readFileSync(0, 'utf8'));
const found = e.extract(line, col, { lookAhead: false });
if (!found || !found.abbreviation) process.exit(0);
const field = (i, p) => '${' + i + (p ? ':' + p : '') + '}';
const snippet = expand(found.abbreviation, { options: { 'output.field': field, 'output.indent': '  ' } });
process.stdout.write(JSON.stringify({ start: found.start, end: found.end, snippet }));
]]

local function in_heex()
	if vim.bo.filetype == 'heex' then return true end
	local ok, parser = pcall(vim.treesitter.get_parser, 0)
	if not ok or not parser then return false end
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	parser:parse(true)
	local lang = parser:language_for_range({ row - 1, col, row - 1, col }):lang()
	return lang == 'heex'
end

local function emmet_expand()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local result = vim.system(
		{ 'node', '-e', emmet_js, emmet_dir },
		{ stdin = vim.json.encode({ line = line:sub(1, col), col = col }) }
	):wait()
	if result.code ~= 0 or result.stdout == '' then return false end

	local found = vim.json.decode(result.stdout)
	vim.api.nvim_buf_set_text(0, row - 1, found.start, row - 1, found['end'], {})
	vim.api.nvim_win_set_cursor(0, { row, found.start })
	vim.snippet.expand(found.snippet)
	return true
end

local function tab()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return
	end
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local before = vim.api.nvim_get_current_line():sub(1, col)
	if before:match('%S$') and in_heex() and emmet_expand() then return end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'ni', false)
end

vim.api.nvim_create_autocmd('FileType', {
	group = vim.api.nvim_create_augroup('heex_editing', { clear = true }),
	pattern = { 'elixir', 'heex' },
	callback = function(ev)
		-- Typing '>' re-indented the line through treesitter, which jumped closing tags around.
		vim.opt_local.indentkeys:remove('>')
		-- 'o' = omnifunc = LSP (Expert functions, Tailwind classes) in the autocomplete popup
		if not vim.bo[ev.buf].complete:find('o') then
			vim.bo[ev.buf].complete = vim.bo[ev.buf].complete .. ',o'
		end
		vim.keymap.set('i', '<Tab>', tab, { buffer = ev.buf, desc = 'Snippet jump / Emmet in HEEx' })
	end,
})
