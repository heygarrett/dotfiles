return {
	{
		"https://github.com/williamboman/mason.nvim",
		cmd = { "Mason", "MasonUpdate" },
		opts = { PATH = "append" },
	},
	{
		"https://github.com/williamboman/mason-lspconfig.nvim",
		opts = {},
	},
	{
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsUpdate" },
		opts = {
			ensure_installed = {
				"basedpyright",
				"bashls",
				"biome",
				"clangd",
				"cmake",
				"commitlint",
				"eslint",
				"fourmolu",
				"goimports",
				"golangci-lint",
				"golangci_lint_ls",
				"gopls",
				"jsonls",
				"lua_ls",
				"marksman",
				"prettierd",
				"ruff",
				"shellcheck",
				"shfmt",
				"stylua",
				"taplo",
				"ts_ls",
				"vimls",
				"yamlfmt",
				"yamlls",
			},
		},
	},
}
