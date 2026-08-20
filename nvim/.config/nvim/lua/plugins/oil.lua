return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
			{ "<leader>o", "<cmd>Oil --float<cr>", desc = "Open parent directory (float)" },
		},
		opts = {
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			watch_for_changes = true,
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 90,
				max_height = 0,
				border = "rounded",
			},
			keymaps = {
				["<leader>y"] = {
					"actions.copy_to_system_clipboard",
					mode = { "n", "v" },
					desc = "Copy to system clipboard",
				},
				["<leader>p"] = {
					"actions.paste_from_system_clipboard",
					desc = "Paste from system clipboard",
				},

				-- Copy absolute path
				["yp"] = {
					function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end

						local path = dir .. entry.name
						vim.fn.setreg("+", path, "c")
						vim.notify("Copied path: " .. path, vim.log.levels.INFO)
					end,
					desc = "Copy absolute path",
				},

				-- Copy relative path
				["yr"] = {
					function()
						local oil = require("oil")
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end

						local path = vim.fn.fnamemodify(dir .. entry.name, ":.")
						vim.fn.setreg("+", path, "c")
						vim.notify("Copied relative path: " .. path, vim.log.levels.INFO)
					end,
					desc = "Copy relative path",
				},
			},
		},
	},

	-- Git status & diagnostics in Oil buffer
	{
		"3p5ilon/oil-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		opts = {},
	},
}
