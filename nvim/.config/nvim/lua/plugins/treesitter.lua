return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			require("nvim-treesitter").setup({
				-- Languages to install parsers for
				ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "html", "css" },
				auto_install = true,
				-- Highlighting
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				-- Indentation
				indent = {
					enable = true,
				},
			})
		end,
	},
}
