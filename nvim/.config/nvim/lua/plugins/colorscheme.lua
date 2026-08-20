return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = "mocha",
			default_integrations = true,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = true,
	-- 	opts = {
	-- 		style = "moon",
	-- 	},
	-- },
}
