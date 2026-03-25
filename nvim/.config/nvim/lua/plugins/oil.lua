return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
			{ "<leader>o", "<cmd>Oil --float<cr>", desc = "Open oil (float)" },
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
				border = "single",
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

				-- ["yp"] = {
				-- 	function()
				-- 		local oil = require("oil")
				-- 		local entry = oil.get_cursor_entry()
				-- 		if not entry then
				-- 			return
				-- 		end
				--
				-- 		local path = oil.get_current_dir() .. entry.name
				-- 		vim.fn.setreg("+", path)
				-- 		vim.notify("Copied path: " .. path, vim.log.levels.INFO)
				-- 	end,
				-- 	desc = "Copy absolute path",
				-- },
				--
				-- ["yr"] = {
				-- 	function()
				-- 		local oil = require("oil")
				-- 		local entry = oil.get_cursor_entry()
				-- 		if not entry then
				-- 			return
				-- 		end
				--
				-- 		local path = vim.fn.fnamemodify(oil.get_current_dir() .. entry.name, ":.")
				-- 		vim.fn.setreg("+", path)
				-- 		vim.notify("Copied relative path: " .. path, vim.log.levels.INFO)
				-- 	end,
				-- 	desc = "Copy relative path",
				-- },
			},
		},
	},
}
