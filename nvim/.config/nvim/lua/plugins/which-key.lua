return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{
					"<leader>w",
					proxy = "<c-w>",
					group = "windows",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
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
			},
		},
	},
}
