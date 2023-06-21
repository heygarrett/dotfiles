return {
	"https://github.com/jose-elias-alvarez/null-ls.nvim",
	dependencies = "https://github.com/nvim-lua/plenary.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			debug = false,
			sources = {
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.prettierd.with({
					env = { PRETTIERD_LOCAL_PRETTIER_ONLY = true },
					condition = function(utils)
						return utils.root_has_file_matches("prettier")
					end,
				}),
				null_ls.builtins.formatting.stylua.with({
					condition = function(utils)
						return utils.root_has_file_matches("stylua")
					end,
				}),
				null_ls.builtins.formatting.yapf,
			},
		})
	end,
}
