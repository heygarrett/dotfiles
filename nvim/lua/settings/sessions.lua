local utils = require("settings.utils")

local sessions = vim.api.nvim_create_augroup("sessions", { clear = true })
-- Load or create session on launch
vim.api.nvim_create_autocmd("VimEnter", {
	group = sessions,
	nested = true,
	callback = function()
		if vim.fn.argc() > 0 then return end
		if not utils.launched_by_user() then return end
		if vim.fn.filereadable("Session.vim") == 1 then
			vim.api.nvim_command("source Session.vim")
		else
			vim.api.nvim_command("mksession")
		end
	end,
})
-- Overwrite existing session when exiting
vim.api.nvim_create_autocmd("VimLeave", {
	group = sessions,
	callback = function()
		if not utils.launched_by_user() then return end
		if vim.fn.filereadable("Session.vim") == 0 then return end
		-- Save session when a session exists and arg list is empty
		local save = "yes"
		if vim.fn.argc() > 0 then
			-- Ask iff session exists but arg list is not empty
			vim.ui.input(
				{ prompt = "Save session? [y/N] " },
				function(input) save = input end
			)
		end
		if save and not save:match("^n") then
			-- Close treesitter-context floating window
			local success, treesitter_context = pcall(require, "treesitter-context")
			if success then treesitter_context.disable() end
			-- Prevent arg list from getting saved in session
			vim.api.nvim_command("%argd | mksession!")
		end
	end,
})
