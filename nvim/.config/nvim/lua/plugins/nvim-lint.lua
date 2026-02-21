return {
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				python = { "pylint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				markdown = { "markdownlint" },
			},
		},
		config = function()
			-- Run linters on save
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
