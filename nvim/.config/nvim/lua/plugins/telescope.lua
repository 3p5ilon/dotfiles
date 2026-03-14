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
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			pcall(require("telescope").load_extension, "fzf")
			require("telescope").load_extension("ui-select") -- Makes LSP code actions appear in Telescope
		end,
		keys = {
			-- Uncomment to use telescope instead of fzf-lua
			-- { "<leader>tff", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
			-- { "<leader>tfg", "<cmd>Telescope live_grep<CR>",   desc = "Live grep" },
			-- { "<leader>tfb", "<cmd>Telescope buffers<CR>",     desc = "Buffers" },
			-- { "<leader>tfr", "<cmd>Telescope oldfiles<CR>",    desc = "Recent files" },
			-- { "<leader>tfw", "<cmd>Telescope grep_string<CR>", desc = "Grep word" },
			-- { "<leader>tfk", "<cmd>Telescope keymaps<CR>",     desc = "Keymaps" },
		},
	},
}
