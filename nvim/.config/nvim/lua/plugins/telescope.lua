return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		config = function()
			require("telescope").setup({})
			pcall(require("telescope").load_extension, "fzf")
		end,
		-- Uncomment to use telescope instead of fzf-lua
		keys = {
			-- { "<leader>tff", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
			-- { "<leader>tfg", "<cmd>Telescope live_grep<CR>",   desc = "Live grep" },
			-- { "<leader>tfb", "<cmd>Telescope buffers<CR>",     desc = "Buffers" },
			-- { "<leader>tfr", "<cmd>Telescope oldfiles<CR>",    desc = "Recent files" },
			-- { "<leader>tfw", "<cmd>Telescope grep_string<CR>", desc = "Grep word" },
			-- { "<leader>tfk", "<cmd>Telescope keymaps<CR>",     desc = "Keymaps" },
		},
	},
}
