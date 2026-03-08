return {
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opts = {} },
			"moll/vim-bbye", -- Better buffer deletion
		},
		version = "*",
		config = function()
			vim.o.mouse = "a"
			vim.o.mousemoveevent = true

			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					mode = "buffers",
					numbers = "none",

					-- separator_style = "thick", -- slant | thick | slope | thin
					always_show_bufferline = true,

					show_buffer_icons = true,
					show_buffer_close_icons = true,
					show_close_icon = false,
					color_icons = true,
					style_preset = bufferline.style_preset.no_italic,

					close_command = "Bdelete! %d", -- using vim-bbye
					right_mouse_command = "Bdelete! %d",

					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},

					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count, level)
						local icons = {
							error = " ",
							warning = " ",
							info = " ",
							hint = "󰌵 ",
						}
						return (icons[level] or "") .. count
					end,

					offsets = {
						{
							filetype = "neo-tree",
							text = "Neo Tree",
							text_align = "left",
							-- highlight = "Directory",
							-- separator = true,
						},
					},
				},
			})

			local map = vim.keymap.set
			map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
			map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Prev buffer" })
			map("n", "<leader>bx", "<cmd>Bdelete<CR>", { desc = "Close buffer" })

			map("n", "<leader>bX", function()
				for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
					vim.cmd("Bdelete! " .. buf.bufnr)
				end
			end, { desc = "Close all buffers" })

			map("n", "<leader>bl", function()
				vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
			end, { desc = "Toggle bufferline" })
		end,
	},
}
