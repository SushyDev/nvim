return {
	'aserowy/tmux.nvim',
	cond = function()
		return os.getenv('TMUX') ~= nil
	end,
	event = 'VeryLazy',
	opts = {
		copy_sync = {
			redirect_to_clipboard = true,
		}
	}
}
