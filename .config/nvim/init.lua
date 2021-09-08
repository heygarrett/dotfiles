require('plugins/packer')
require('plugins/lualine')
require('plugins/coq')
require('plugins/lspconfig')
require('plugins/nvim-lint')
require('plugins/indent-blankline')
vim.cmd('source $HOME/.config/nvim/viml/autocmds.vim')

vim.g.python3_host_prog = vim.env.HOME .. "/.local/venvs/nvim/bin/python"
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.g.netrw_liststyle = 3
vim.opt.hidden = true -- soon to be default (merged into master)
vim.opt.path:append({'**'})
vim.opt.cmdheight = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.confirm = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'
vim.opt.clipboard:append({'unnamedplus'})
vim.opt.mouse = 'a'
