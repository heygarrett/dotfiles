return {
	"rebelot/kanagawa.nvim",
	config = function()
		local default_colors = require("kanagawa.colors").setup()
		local overrides = {
			CursorLineNr = { fg = default_colors.lightBlue },
		}
		require("kanagawa").setup({
			overrides = overrides,
			commentStyle = {},
			keywordStyle = {},
			statementStyle = {},
			variablebuiltinStyle = {},
			specialReturn = false,
		})
		vim.cmd.colorscheme({
			args = { "kanagawa" },
		})
	end,
}
