-- tmux.nvim: only load inside a tmux session
if os.getenv('TMUX') ~= nil then
	require('tmux').setup({
		copy_sync = {
			redirect_to_clipboard = true,
		},
	})
end
