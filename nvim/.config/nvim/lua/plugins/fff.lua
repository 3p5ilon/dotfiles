return {
	{
		"dmtrKovalenko/fff",
		lazy = true,
		build = function()
			local ok, download = pcall(require, "fff.download")
			if ok then
				download.download_or_build_binary()
			end
		end,
		cmd = { "FFF", "FFFOpen" },
		opts = {
			layout = {
				height = 0.80,
				width = 0.80,
				prompt_position = "top",
			},
			keymaps = {
				move_down = "<C-j>",
				move_up = "<C-k>",
				select = "<CR>",
				close = "<Esc>",
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					require("fff").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("fff").live_grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>fw",
				function()
					require("fff").live_grep_under_cursor()
				end,
				mode = { "n", "x" },
				desc = "Grep word under cursor",
			},
			{
				"<leader>fz",
				function()
					require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
				end,
				desc = "Fuzzy live grep",
			},
		},
	},
}
