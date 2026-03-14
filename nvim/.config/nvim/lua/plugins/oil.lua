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
				["<leader>y"] = { "actions.copy_to_system_clipboard", mode = { "n", "v" } },
				["<leader>p"] = "actions.paste_from_system_clipboard",
			},
		},
	},
}
