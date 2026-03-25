return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		keys = {
			{ "<leader>e", "<Cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
		},
		opts = {
			close_if_last_window = true, -- Close tree if it's last window
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "left",
				width = 32,
				mappings = {
					["<space>"] = "toggle_node",
					["<cr>"] = "open",
					["s"] = "open_vsplit",
					["S"] = "open_split",

					["yp"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()

						vim.fn.setreg("+", path, "c")
						vim.notify("Copied path: " .. path, vim.log.levels.INFO)
					end,

					["yr"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						local rel = vim.fn.fnamemodify(path, ":.")

						vim.fn.setreg("+", rel, "c")
						vim.notify("Copied relative path: " .. rel, vim.log.levels.INFO)
					end,
				},
			},
			filesystem = {
				follow_current_file = { enabled = true }, -- Auto-follow current file
				use_libuv_file_watcher = true, -- Auto-refresh on file changes
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
}
