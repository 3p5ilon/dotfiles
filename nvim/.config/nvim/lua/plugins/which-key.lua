return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.add({
				-- groups
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },

				{ "<leader>w", proxy = "<c-w>", group = "windows" },
				{ "<leader>q", "<cmd>q<cr>", desc = "Quit" },
				{ "<leader>Q", "<cmd>qa<cr>", desc = "Quit all" },
				{ "<leader>t", group = "test" },

				{
					"<leader>b",
					group = "buffers",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
			})
		end,
	},
}
