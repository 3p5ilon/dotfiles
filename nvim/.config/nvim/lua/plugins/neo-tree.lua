return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = false,
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
	},
	opts = {
		close_if_last_window = true,
		enable_git_status = true,
		enable_diagnostics = true,
		filesystem = {
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
			},
		},
		window = {
			position = "left",
			width = 30,
			mappings = {
				["<space>"] = "toggle_node",
				["<cr>"] = "open",
				["s"] = "open_vsplit",
				["S"] = "open_split",

				-- Copy absolute path
				["yp"] = function(state)
					local path = state.tree:get_node():get_id()
					vim.fn.setreg("+", path, "c")
					vim.notify("Copied path: " .. path, vim.log.levels.INFO)
				end,

				-- Copy relative path
				["yr"] = function(state)
					local path = state.tree:get_node():get_id()
					local rel = vim.fn.fnamemodify(path, ":.")
					vim.fn.setreg("+", rel, "c")
					vim.notify("Copied relative path: " .. rel, vim.log.levels.INFO)
				end,
			},
		},
	},
}
