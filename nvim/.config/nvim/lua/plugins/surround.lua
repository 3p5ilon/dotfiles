return {
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa", -- Add surround (e.g., gsaiw")
				delete = "gsd", -- Delete surround (e.g., gsd")
				find = "gsf", -- Search forward for surround
				find_left = "gsF", -- Search backward for surround
				highlight = "gsh", -- Visually highlight target surround
				replace = "gsr", -- Replace surround (e.g., gsr"')
				update_n_lines = "gsn", -- Adjust line search distance
			},
			n_lines = 20, -- How many lines above/below to search for surrounds
		},
	},
}
