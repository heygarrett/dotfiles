local lint = require('lint')
lint.linters_by_ft = {
	javascript = {'eslint'},
	typescript = {'eslint'},
	lua = {'luacheck'},
}
local f = io.open('./node_modules/.bin/eslint', 'r')
if f ~= nil then
	io.close(f)
	lint.linters.eslint.cmd = './node_modules/.bin/eslint'
end

vim.cmd([[autocmd BufEnter,InsertLeave * lua require('lint').try_lint()]])
