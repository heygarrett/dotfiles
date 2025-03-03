vim.keymap.set("i", "<cr>", function()
	local pum_info = vim.fn.complete_info({ "mode", "selected" })
	if pum_info.mode ~= "" and pum_info.selected == -1 then
		return "<c-e><cr>"
	else
		return "<cr>"
	end
end, {
	expr = true,
	desc = "workaround for pop-up menu issue in vim",
	-- HACK: https://github.com/vim/vim/issues/1653
})

vim.keymap.set("i", "<c-space>", "<c-x><c-o>", { desc = "omnicompletion" })

vim.keymap.set("v", "zz", function()
	local first_line = vim.fn.getpos("v")[2]
	local last_line = vim.fn.getpos(".")[2]
	local middle_line = math.floor((first_line + last_line) / 2)
	vim.cmd.normal({
		args = { vim.keycode("<esc>") },
	})
	vim.api.nvim_win_set_cursor(0, { middle_line, 0 })
	vim.cmd.normal({
		args = { "zz" },
	})
	vim.cmd.normal({
		args = { "gv" },
	})
end, { desc = "vertically center visual selection" })
