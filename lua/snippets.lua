-- Tiny snippet expander on top of native vim.snippet (no plugins).
-- Type a trigger, press <C-j> to expand, <Tab>/<S-Tab> to jump between fields.
-- :Snippets lists the triggers for the current filetype.

local heex = {
	hform = '<.form for={@${1:form}} id="${2:form-id}" phx-submit="${3:save}">\n\t$0\n\t<.button class="btn btn-primary w-full">${4:Save}</.button>\n</.form>',
	hsel = '<.input field={@${1:form}[:${2:field}]} type="select" options={${3:@options}} label="${4:Label}" />$0',
	-- Long inputs are pre-split the way mix format lays them out, so format never rewrites them
	idec = '<.input\n\tfield={@${1:form}[:${2:field}]}\n\ttype="text"\n\tinputmode="decimal"\n\tplaceholder="0.00"\n\tlabel="${3:Label}"\n/>$0',
	isel = '<.input\n\tfield={@${1:form}[:${2:field}]}\n\ttype="select"\n\toptions={${3:@options}}\n\tlabel="${4:Label}"\n/>$0',
	hstats = '<div class="stats shadow w-full">\n\t$0\n</div>',
	hgrid = '<div class="grid gap-4 md:grid-cols-${1:3}">\n\t$0\n</div>',
	itxt = '<.input field={@${1:form}[:${2:field}]} type="text" label="${3:Label}" />$0',
	hfor = '<li :for={${1:item} <- @${2:items}} id={"${3:item}-#{$1.${4:id}}"}>$0</li>',
	hstat = '<div class="stat">\n\t<div class="stat-title">${1:Title}</div>\n\t<div id="${2:stat-id}" class="stat-value tabular-nums">{${3:@value}}</div>\n</div>$0',
	hcard = '<div class="card bg-base-200">\n\t<div class="card-body">\n\t\t<h3 class="card-title">${1:Title}</h3>\n\t\t$0\n\t</div>\n</div>',
	hbtn = '<.button phx-click="${1:event}" phx-value-id={${2:item}.id}>$0</.button>',
	lapp = '<Layouts.app flash={@flash}>\n\t$0\n</Layouts.app>',
}

local elixir = {
	-- Functions: block form, and the one-line `, do:` form
	def = 'def ${1:name}(${2:args}) do\n\t$3\nend$0',
	defp = 'defp ${1:name}(${2:args}) do\n\t$3\nend$0',
	defi = 'def ${1:name}(${2:args}), do: $3$0',
	defpi = 'defp ${1:name}(${2:args}), do: $3$0',

	-- LiveView
	mount = '@impl true\ndef mount(${1:_params}, ${2:_session}, socket) do\n\t{:ok, ${3:socket}}\nend$0',
	render = '@impl true\ndef render(assigns) do\n\t~H"""\n\t$0\n\t"""\nend',
	hev = '@impl true\ndef handle_event("${1:event}", %{"${2:form}" => %{"${3:field}" => ${4:value}}}, socket) do\n\t$0\nend',
	hinfo = '@impl true\ndef handle_info(${1:msg}, socket) do\n\t$0\n\t{:noreply, socket}\nend',
	hpar = '@impl true\ndef handle_params(${1:_params}, ${2:_url}, socket) do\n\t{:noreply, ${3:socket}}\nend$0',
	asg = 'assign(socket, :${1:key}, ${2:value})$0',
	pf = 'put_flash(socket, :${1:info}, "$0")',
	form = 'to_form(%{}, as: :${1:form})$0',
	ref = 'defp refresh(socket) do\n\tassign(socket,\n\t\t${1:key}: ${2:value},\n\t\t${3:form}: to_form(%{}, as: :$3)\n\t)\nend$0',
	toi = '${1:id} = String.to_integer($1)$0',
	byid = 'Map.new(${1:rows}, &{&1.${2:id}, &1})$0',
	opts = 'Enum.map(${1:rows}, &{"#{&1.${2:name}} (#{${3:format_cents}(&1.${4:total})})", &1.${5:id}})$0',
	nrf = '{:noreply,\n socket\n |> put_flash(:${1:info}, "$2")\n |> ${3:refresh}()}$0',

	-- GenServer
	init = '@impl true\ndef init(${1:arg}) do\n\t{:ok, ${2:state}}\nend$0',
	hcall = '@impl true\ndef handle_call(${1:request}, ${2:_from}, state) do\n\t{:reply, ${3:reply}, state}\nend$0',
	hcast = '@impl true\ndef handle_cast(${1:request}, state) do\n\t{:noreply, ${2:state}}\nend$0',

	-- Control flow
	wok = 'with {:ok, ${1:value}} <- ${2:call} do\n\t$0\nend',
	cok = 'case ${1:expr} do\n\t{:ok, ${2:value}} -> $3\n\t{:error, ${4:reason}} -> $0\nend',

	-- Data / money
	tx = 'Repo.transaction(fn ->\n\t$0\nend)',
	txm = 'Repo.transaction(fn ->\n\tRepo.insert!(%${1:Mod}{$2})\n\tRepo.insert!(%$1{$3})\nend)$0',
	ins = 'Repo.insert!(%${1:Mod}{$2})$0',
	csum = 'coalesce(sum(fragment("CASE WHEN ? = \'${1:value}\' THEN ? ELSE -? END", ${2:r}.${3:type}, $2.${4:amount}, $2.$4)), 0)$0',
	ljq = 'from(${1:p} in ${2:Parent},\n\tleft_join: ${3:c} in ${4:Child},\n\ton: $3.${5:parent_id} == $1.id,\n\tgroup_by: $1.id,\n\torder_by: $1.id,\n\tselect: %{${6:parent}: $1, ${7:total}: $8}\n)$0',
	ljm = 'from(${1:p} in ${2:Parent},\n\tleft_join: ${3:c} in ${4:Child},\n\ton: $3.${5:parent_id} == $1.id,\n\tgroup_by: $1.id,\n\torder_by: $1.id,\n\tselect_merge: %{${6:total}: ${7:count}($3.${8:id})}\n)$0',
	vfield = 'field :${1:total}, :${2:integer}, virtual: true, default: ${3:0}$0',
	cents = 'defp to_cents(str), do: str |> Decimal.new() |> Decimal.mult(100) |> Decimal.to_integer()\ndefp format_cents(c), do: c |> Decimal.new() |> Decimal.div(100) |> Decimal.round(2) |> Decimal.to_string()$0',
}

-- ~H templates live inside .ex files, so elixir buffers get the HEEx snippets too
local by_ft = {
	elixir = vim.tbl_extend('error', elixir, heex),
	heex = heex,
}

local function expand()
	local snippets = by_ft[vim.bo.filetype]
	if not snippets then return end

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local before = vim.api.nvim_get_current_line():sub(1, col)
	local trigger = before:match('[%w_]+$')
	local body = trigger and snippets[trigger]
	if not body then return end

	vim.api.nvim_buf_set_text(0, row - 1, col - #trigger, row - 1, col, {})
	vim.api.nvim_win_set_cursor(0, { row, col - #trigger })
	vim.snippet.expand(body)
end

vim.keymap.set('i', '<C-j>', expand, { desc = 'Expand snippet' })

-- Show snippets in the native completion popup (autocomplete and <C-n>/<C-p>).
-- The popup inserts the trigger word; accepting it (<C-y> or <C-s>) expands the snippet.
function _G.SnippetComplete(findstart, base)
	local snippets = by_ft[vim.bo.filetype] or {}
	if findstart == 1 then
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local before = vim.api.nvim_get_current_line():sub(1, col)
		return col - #before:match('[%w_]*$')
	end
	local items = {}
	for trigger, body in pairs(snippets) do
		if base ~= '' and vim.startswith(trigger, base) then
			table.insert(items, { word = trigger, kind = 'snip', menu = '[snippet]', info = body, user_data = 'snippet', dup = 1 })
		end
	end
	table.sort(items, function(a, b) return a.word < b.word end)
	return items
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = vim.tbl_keys(by_ft),
	callback = function(ev)
		vim.bo[ev.buf].completefunc = 'v:lua.SnippetComplete'
		if not vim.startswith(vim.bo[ev.buf].complete, 'F,') then
			vim.bo[ev.buf].complete = 'F,' .. vim.bo[ev.buf].complete
		end
	end,
})

vim.api.nvim_create_autocmd('CompleteDone', {
	callback = function()
		local item = vim.v.completed_item
		if vim.v.event.reason == 'accept' and item and item.user_data == 'snippet' then
			vim.schedule(expand)
		end
	end,
})

-- <C-s> accepts the selected popup item, same as <C-y>
vim.keymap.set('i', '<C-s>', function()
	if vim.fn.pumvisible() == 0 then return '<C-s>' end
	-- nothing highlighted yet: take the first item
	return vim.fn.complete_info({ 'selected' }).selected == -1 and '<C-n><C-y>' or '<C-y>'
end, { expr = true, desc = 'Accept completion' })

vim.api.nvim_create_user_command('Snippets', function()
	local snippets = by_ft[vim.bo.filetype] or {}
	local names = vim.tbl_keys(snippets)
	table.sort(names)
	print(table.concat(names, '  '))
end, { desc = 'List snippet triggers' })

return { expand = expand }
