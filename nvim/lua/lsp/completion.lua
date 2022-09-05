local M = {}

M.setup = function(bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.keymap.set("i", "<c-space>", "<c-x><c-o>")
	-- https://github.com/vim/vim/issues/1653
	vim.keymap.set("i", "<cr>", function()
		if vim.fn.pumvisible() == 1 and vim.fn.complete_info()["selected"] == -1 then
			return "<c-e><cr>"
		else
			return "<cr>"
		end
	end, { expr = true })
	-- Auto-complete
	vim.api.nvim_create_augroup("completion", { clear = false })
	vim.api.nvim_clear_autocmds({ group = "completion", buffer = bufnr })
	vim.api.nvim_create_autocmd("TextChangedI", {
		group = "completion",
		buffer = bufnr,
		callback = function()
			if vim.g.pum_timer then vim.fn.timer_stop(vim.g.pum_timer) end
			if
				vim.fn
					.getline(".")
					:sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1)
					:match("[%w_.]")
			then
				vim.g.pum_timer = vim.fn.timer_start(300, function()
					if vim.fn.mode():match("^[^i]") then return end
					local keys =
						vim.api.nvim_replace_termcodes("<c-x><c-o>", true, true, true)
					vim.api.nvim_feedkeys(keys, "n", false)
				end)
			end
		end,
	})
end

return M
