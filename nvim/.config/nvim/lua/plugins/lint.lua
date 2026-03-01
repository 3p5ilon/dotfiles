return {
	-- nvim-lint: runs additional linters on save
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				-- python = { "pylint" },  -- requires: pylint
				-- cpp = { "clang-tidy" }, -- requires: clang-tidy
				-- c = { "clang-tidy" },   -- requires: clang-tidy
				-- javascript = { "eslint" },
				-- typescript = { "eslint" },
				-- javascriptreact = { "eslint" },
				-- typescriptreact = { "eslint" },
			}
			-- Run linters on save
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
