return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		search = {
			multi_window = false, -- Active window only
			wrap = false, -- No buffer wrapping
		},
		jump = {
			history = true, -- Save to jumplist (<C-o>)
			autojump = false, -- Require explicit label press
		},
		label = {
			uppercase = false, -- Lowercase labels only
		},
		modes = {
			search = {
				enabled = false, -- Keep native / search
			},
			char = {
				enabled = true, -- Enhance f/F/t/T motions
				autohide = true, -- Hide labels on fast typing
			},
		},
	},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<C-s>", mode = "c", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
