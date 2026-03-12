return {
	-- renders markdown formatting
	{
		"meanderingprogrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = { "markdown" },
		opts = {
			-- render_modes = true,
		},
	},

	-- renders latex directly in buffer
	{
		"jbyuki/nabla.nvim",
		ft = { "markdown", "tex" },
		config = function()
			local nabla = require("nabla")

			vim.keymap.set("n", "<leader>m", function()
				nabla.toggle_virt()
			end, { desc = "Toggle LaTeX rendering" })
		end,
	},

	-- Live markdown preview in browser (requires npm)
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	ft = { "markdown" },
	-- 	build = "cd app && npm install",
	-- 	keys = {
	-- 		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle preview" },
	-- 	},
	-- },
}
