return {
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					numbers = "none",
					close_command = "bdelete %d",
					diagnostics = "nvim_lsp",
					separator_style = "thick",
					show_buffer_close_icons = true,
					show_close_icon = false,
					always_show_bufferline = true,
					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo Tree",
							text_align = "left",
							-- separator = true,
						},
					},
				},
			})

			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
			vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>")

			vim.keymap.set("n", "<leader>bl", function()
				vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
			end, { desc = "Toggle bufferline" })
		end,
	},
}
