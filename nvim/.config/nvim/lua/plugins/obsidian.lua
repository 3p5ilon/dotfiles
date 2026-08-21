return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"saghen/blink.cmp",
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
				blink = true,
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
