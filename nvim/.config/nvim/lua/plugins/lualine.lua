return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					icons_enabled = true,

					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },

					disabled_filetypes = {
						statusline = { "dashboard", "alpha" },
					},
				},

				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "", right = "" },
							right_padding = 2,
						},
					},

					lualine_b = {
						{ "branch", icon = "" },

						{
							"diff",
							symbols = {
								added = "+",
								modified = "~",
								removed = "-",
							},
						},
					},

					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 0,
						},
					},

					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
							},
						},
						"encoding",
						"fileformat",
						"filetype",
					},

					lualine_y = { "progress" },

					lualine_z = {
						{
							"location",
							separator = { left = "", right = "" },
							left_padding = 2,
						},
					},
				},

				extensions = { "neo-tree", "lazy" },
			})
		end,
	},
}
