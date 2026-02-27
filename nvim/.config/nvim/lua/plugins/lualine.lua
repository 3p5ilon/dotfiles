return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local lualine = require("lualine")
			local colors = require("catppuccin.palettes").get_palette()
			lualine.setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					icons_enabled = true,
					component_separators = "",
					-- component_separators = { left = "", right = "" },
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
						{
							"branch",
							icon = "",
							separator = { left = "", right = "" },
						},
					},
					lualine_c = {
						{
							"diff",
							colored = true,
							diff_color = {
								added = { fg = colors.green, bg = "none" },
								modified = { fg = colors.yellow, bg = "none" },
								removed = { fg = colors.red, bg = "none" },
							},
							symbols = {
								added = "+",
								modified = "~",
								removed = "-",
							},
						},
						{
							"filename",
							file_status = true,
							path = 1,
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
