return {
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = false,

		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},

		opts = {
			workspaces = {
				{
					name = "vault",
					path = "~/Documents/vault",
				},
			},

			notes_subdir = "notes",

			daily_notes = {
				folder = "daily",
				date_format = "%Y-%m-%d",
			},

			attachments = {
				folder = "assets",
			},

			completion = {
				nvim_cmp = true,
				min_chars = 2,
			},
		},

		config = function(_, opts)
			require("obsidian").setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.conceallevel = 1
				end,
			})
		end,
	},
}
