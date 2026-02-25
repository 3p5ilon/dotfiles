return {
	-- Renders markdown formatting (headings, checkboxes, code blocks)
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = { "markdown" },
		opts = {},
	},

	-- Renders LaTeX math formulas directly in buffer
	{
		"jbyuki/nabla.nvim",
		ft = { "markdown", "tex" },
		config = function()
			local nabla = require("nabla")
			local nabla_group = vim.api.nvim_create_augroup("NablaAuto", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = nabla_group,
				pattern = { "*.md", "*.tex" },
				callback = function()
					-- Automatically show the rendered math
					nabla.enable_virt()
				end,
			})
			vim.keymap.set("n", "<leader>m", function() -- toggle rendered math
				nabla.toggle_virt()
			end, { desc = "Toggle LaTeX" })
		end,
	},

	-- Live markdown preview in browser (requires node/npm)
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
