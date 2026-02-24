return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"python",
					"c",
					"cpp",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"json",
					"yaml",
					"latex",
				},
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },
			})
		end,
	},
}
