return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function()
			local style = "rounded" -- "sharp" | "rounded" | "soft" | "slant"

			local styles = {
				sharp = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = nil,
					padding = { a = { left = 2, right = 1 }, z = { left = 1, right = 2 } },
				},
				slant = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					-- component = { left = "", right = "" },
					-- section = { left = "", right = "" },
					edge = nil,
					padding = { a = { left = 2, right = 1 }, z = { left = 1, right = 2 } },
				},
				rounded = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = { left = "", right = "" },
					padding = { a = { left = 1, right = 1 }, z = { left = 0, right = 1 } },
				},
				soft = {
					component = { left = "", right = "" },
					section = { left = "", right = "" },
					edge = nil,
					padding = { a = { left = 2, right = 1 }, z = { left = 0, right = 2 } },
				},
			}

			local s = styles[style]

			local function edge_separator()
				if not s or not s.edge then
					return nil
				end
				return { left = s.edge.left, right = s.edge.right }
			end

			return {
				options = {
					theme = "auto",
					icons_enabled = true,
					globalstatus = true,
					component_separators = s.component,
					section_separators = s.section,
					disabled_filetypes = {
						statusline = { "lazy", "alpha", "starter", "lazygit" },
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
							symbols = { added = " ", modified = " ", removed = " " },
							-- symbols = { added = " ", modified = " ", removed = " " },
						},
					},

					lualine_c = {
						{ "filename", file_status = true, path = 0 },
					},

					lualine_x = {
						-- -- Macro recording state
						-- {
						-- 	function()
						-- 		return "%#Constant#" .. require("noice").api.status.mode.get()
						-- 	end,
						-- 	cond = function()
						-- 		return package.loaded["noice"] and require("noice").api.status.mode.has()
						-- 	end,
						-- },
						-- -- Command mode state
						-- {
						-- 	function()
						-- 		return "%#Statement#" .. require("noice").api.status.command.get()
						-- 	end,
						-- 	cond = function()
						-- 		return package.loaded["noice"] and require("noice").api.status.command.has()
						-- 	end,
						-- },
						-- -- Search count
						-- {
						-- 	function()
						-- 		return "%#DiagnosticWarn#" .. require("noice").api.status.search.get()
						-- 	end,
						-- 	cond = function()
						-- 		return package.loaded["noice"] and require("noice").api.status.search.has()
						-- 	end,
						-- },
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = {
								error = " ",
								warn = " ",
								info = " ",
								hint = "󰌵 ",
								-- hint  = " ",
							},
						},
						-- "encoding",
						-- "fileformat",
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

				extensions = { "neo-tree", "oil", "lazy", "mason", "fzf" },
			}
		end,
	},
}
