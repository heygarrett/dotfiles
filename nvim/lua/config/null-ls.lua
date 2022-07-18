return {
	"jose-elias-alvarez/null-ls.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		vim.api.nvim_create_augroup("null-ls", { clear = true })
		local null_ls = require("null-ls")
		null_ls.setup {
			sources = {
				null_ls.builtins.code_actions.eslint_d,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.editorconfig_checker.with({
					command = "editorconfig-checker",
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = "null-ls",
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.formatting_sync()
						end,
					})
				end
			end
		}
	end
}
