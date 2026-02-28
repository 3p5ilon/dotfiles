return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local style = "rounded" -- "sharp" | "rounded"

			local separator_styles = {
				rounded = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge_left = "",
					edge_right = "",
					-- padding_a = { left = 1, right = 1 },
					-- padding_z = { left = 1, right = 1 },
				},
				sharp = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge_left = nil,
					edge_right = nil,
					padding_a = { left = 2, right = 1 },
					padding_z = { left = 1, right = 2 },
				},
			}

			local s = separator_styles[style]

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
					icons_enabled = true,
					component_separators = s.component,
					section_separators = s.section,
					disabled_filetypes = {
						statusline = { "dashboard", "alpha" },
					},
				},

				sections = {
					lualine_a = {
						{
							"mode",
							separator = style == "rounded" and { left = s.edge_left, right = s.edge_right } or nil,
							padding = s.padding_a,
						},
					},

					lualine_b = {
						{ "branch", icon = "" },
						{ "diff", symbols = { added = "+", modified = "~", removed = "-" } },
					},

					lualine_c = {
						{ "filename", file_status = true, path = 0 },
					},

					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " " },
						},
						"encoding",
						"fileformat",
						"filetype",
					},

					lualine_y = { "progress" },

					lualine_z = {
						{
							"location",
							separator = style == "rounded" and { left = s.edge_left, right = s.edge_right } or nil,
							padding = s.padding_z,
						},
					},
				},

				extensions = { "neo-tree", "lazy" },
			})
		end,
	},
}
