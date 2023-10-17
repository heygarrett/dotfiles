local helpers = require("my.helpers")

---@param ref string
---@param file string|nil
---@return string[]
local get_commits = function(ref, file)
	local cmd_components = {
		"git log --pretty='format:" .. table.concat({
			"%h",
			"(%cr)",
			"%s",
			"<%ae>",
		}, " ") .. "'",
	}
	if ref ~= "" then
		table.insert(cmd_components, ref .. "..HEAD")
	end
	if file then
		table.insert(cmd_components, file)
	end

	return vim.split(
		vim.fn.system(table.concat(cmd_components, " ")),
		"\n",
		{ trimempty = true }
	)
end

---@param item string
local copy_commit_hash = function(item)
	local commit = item:match("[^ ]+")
	vim.fn.setreg("+", commit)
	---@diagnostic disable: param-type-mismatch
	vim.defer_fn(function() vim.notify(commit .. " copied to clipboard!") end, 500)
end

return {
	"https://github.com/echasnovski/mini.pick",
	config = function()
		local pick = require("mini.pick")
		pick.setup()

		vim.api.nvim_create_user_command("BCommits", function(opts)
			local relative_file = vim.fn.expand("%:.")
			pick.start({
				source = {
					name = "BCommits",
					items = get_commits(opts.args, relative_file),
					choose = copy_commit_hash,
					preview = function(buf_id, item)
						vim.bo[buf_id].filetype = "diff"
						local hash = item:match("[^ ]+")
						local lines = vim.split(
							vim.fn.system({
								"git",
								"diff",
								hash,
								"--",
								relative_file,
							}),
							"\n",
							{ trimempty = true }
						)
						vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
					end,
				},
			})
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "mini.pick: buffer commits",
		})

		vim.api.nvim_create_user_command("Commits", function(opts)
			pick.start({
				source = {
					items = get_commits(opts.args),
					name = "Commits",
					choose = copy_commit_hash,
					preview = function(buf_id, item)
						vim.bo[buf_id].filetype = "diff"
						local hash = item:match("[^ ]+")
						local lines = vim.split(
							vim.fn.system({ "git", "show", hash }),
							"\n",
							{ trimempty = true }
						)
						vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
					end,
				},
			})
		end, {
			nargs = "?",
			complete = helpers.get_branches,
			desc = "mini.pick: commits",
		})

		vim.api.nvim_create_user_command("Find", function()
			vim.fn.system({ "git", "rev-parse", "--is-inside-work-tree" })
			if vim.v.shell_error == 0 then
				pick.builtin.files({ tool = "git" })
			else
				pick.builtin.files()
			end
		end, { desc = "mini.pick: find files" })

		-- LSP lists
		vim.api.nvim_create_user_command("References", function()
			vim.lsp.buf.references({
				method = "textDocument/references",
				bufnr = 0,
			}, {
				on_list = function(opts)
					-- print(vim.inspect(opts.items))
					pick.start({
						source = {
							items = vim.tbl_map(
								function(item)
									return ("%s:%d:%d: %s"):format(
										vim.fn.fnamemodify(item.filename, ":~:."),
										item.lnum,
										item.col,
										item.text:gsub("\t", "")
									)
								end,
								opts.items
							),
							name = opts.title,
						},
					})
				end,
			})
		end, { desc = "mini.pick: LSP references" })
	end,
}
