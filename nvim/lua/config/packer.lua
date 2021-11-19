vim.api.nvim_command('autocmd BufWritePost packer.lua source <afile> | PackerCompile')

local packer_bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system {
		'git', 'clone', '--depth', '1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	}
end

require('packer').startup {
	function(use)
		use {
			-- Self-manage
			'wbthomason/packer.nvim',

			-- No configs
			'editorconfig/editorconfig-vim',
			'farmergreg/vim-lastplace',
			'tpope/vim-markdown',
			'tpope/vim-sleuth',

			-- Configs
			require('config/Comment'),
			require('config/lualine'),
			require('config/nvim-lspconfig'),
			require('config/nvim-treesitter'),
			require('config/telescope'),
			require('config/tokyonight'),
			require('config/vim-indexed-search'),
		}

		if packer_bootstrap then
			require('packer').sync()
		end
	end,

	config = {
		display = {
			open_fn = require('packer/util').float,
		}
	},
}
