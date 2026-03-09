return {
	-- nvim-lint: extra linting on save (beyond LSP diagnostics)
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost",
		config = function()
			require("lint").linters_by_ft = {
				python = { "pylint" },
			}

			-- Trigger linting after every save
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
