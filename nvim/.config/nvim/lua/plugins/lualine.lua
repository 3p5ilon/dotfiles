return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			local style = "rounded" -- "sharp" | "rounded" | "soft"

			local styles = {

				sharp = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = nil,
					padding = {
						a = { left = 2, right = 1 },
						z = { left = 1, right = 2 },
					},
				},

				rounded = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = { left = "", right = "" },
					padding = {
						a = { left = 1, right = 1 },
						z = { left = 0, right = 1 },
					},
				},

				soft = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = nil,
					padding = {
						a = { left = 2, right = 1 },
						z = { left = 0, right = 2 },
					},
				},
			}

			local s = styles[style]

			local function edge_separator()
				if not s.edge then
					return nil
				end
				return { left = s.edge.left, right = s.edge.right }
			end

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
							-- fmt = function(str)
							-- 	return " " .. str
							-- end,
							separator = edge_separator(),
							padding = s.padding.a,
						},
					},

					lualine_b = {
						{ "branch", icon = "" },
						{
							"diff",
							symbols = { added = "+", modified = "~", removed = "-" },
						},
					},

					lualine_c = {
						{ "filename", file_status = true, path = 0 },
					},

					lualine_x = {
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰌵 ",
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
							separator = edge_separator(),
							padding = s.padding.z,
						},
					},
				},

				extensions = { "neo-tree", "lazy" },
			})
		end,
	},
}
