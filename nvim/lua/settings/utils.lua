-- Sort lines by length
vim.api.nvim_create_user_command("Sort", function(t)
	local line_list = vim.api.nvim_buf_get_lines(0, t.line1 - 1, t.line2, true)
	table.sort(line_list, function(a, b)
		local a_len = vim.fn.strdisplaywidth(a)
		local b_len = vim.fn.strdisplaywidth(b)
		if a_len == b_len then
			return a < b
		elseif t.bang then
			return a_len > b_len
		else
			return a_len < b_len
		end
	end)
	vim.api.nvim_buf_set_lines(0, t.line1 - 1, t.line2, true, line_list)
end, { range = "%", bang = true })

local M = {}

-- Check nvim's parent process
M.launched_by_user = function()
	local parent_process = vim.fn.system(
		string.format(
			"ps -o ppid= -p %s | xargs ps -o comm= -p | tr -d '\n'",
			vim.fn.getpid()
		)
	)
	return parent_process == "-fish"
end

return M
