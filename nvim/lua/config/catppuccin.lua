return {
	"catppuccin/nvim",
	as = "catppuccin",
	config = function()
		local loaded, _ = pcall(require, "catppuccin")
		if not loaded then return end

		vim.g.catppuccin_flavour = "mocha"
		vim.api.nvim_command("colorscheme catppuccin")
	end,
}
