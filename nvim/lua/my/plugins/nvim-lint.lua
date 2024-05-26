local linters_by_ft = {
	fish = { "fish" },
}
local filetypes = vim.tbl_keys(linters_by_ft)

return {
	"https://github.com/mfussenegger/nvim-lint",
	lazy = true,
	ft = filetypes,
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = linters_by_ft

		local group = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd(
			{ "BufWritePost", "InsertLeave", "TextChanged" },
			{
				desc = "nvim-lint",
				group = group,
				callback = function() lint.try_lint() end,
			}
		)
	end,
}
