return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters (from conform.lua)
					"stylua",
					"black",
					"isort",
					"clang-format",
					"prettier",

					-- Linters (from lint.lua)
					"pylint",
				},
				run_on_start = true,
			})
		end,
	},
}
