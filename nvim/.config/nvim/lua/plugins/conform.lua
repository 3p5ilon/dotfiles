return {
	-- Conform: auto-formats on save
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				markdown = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback", -- use LSP if no formatter found
			},
		},
	},
}
