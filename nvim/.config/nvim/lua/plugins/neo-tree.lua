return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = {
			{ "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
		},
		opts = {
			close_if_last_window = true, -- Close tree if it's last window
			enable_git_status = true, -- Show git status
			enable_diagnostics = true, -- Show LSP diagnostics
			window = {
				position = "left",
				width = 35,
				mappings = {
					["<space>"] = "toggle_node",
					["<cr>"] = "open",
					["s"] = "open_vsplit", -- Open in vertical split
					["S"] = "open_split", -- Open in horizontal split
				},
			},
			filesystem = {
				follow_current_file = { enabled = true }, -- Auto-follow current file
				use_libuv_file_watcher = true, -- Auto-refresh on file changes
				filtered_items = {
					hide_dotfiles = false, -- Show dotfiles (like .gitignore)
					hide_gitignored = false, -- Show gitignored files
				},
			},
		},
	},
}
