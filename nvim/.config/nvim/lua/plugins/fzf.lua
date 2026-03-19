return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		cmd = "FzfLua",
		keys = {
			-- files
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
			-- search
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
			{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
			{ "<leader>f/", "<cmd>FzfLua blines<cr>", desc = "Fuzzy find in buffer" },
			{ "<leader>fl", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Live grep in buffer" },
			-- LSP
			{ "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Diagnostics" },
			-- git
			{ "<leader>fgf", "<cmd>FzfLua git_files<cr>", desc = "Git files" },
			{ "<leader>fgc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
		},
		opts = function()
			-- local actions = require("fzf-lua.actions")
			return {
				winopts = {
					width = 0.8,
					height = 0.8,
					row = 0.5,
					col = 0.5,
					preview = {
						scrollchars = { "┃", "" },
					},
				},
				-- files = {
				-- 	cwd_prompt = false,
				-- 	actions = {
				-- 		["ctrl-h"] = { actions.toggle_hidden },  -- toggle dotfiles visibility
				-- 		["ctrl-u"] = { actions.toggle_ignore },  -- toggle .gitignore rules
				-- 	},
				-- },
				-- grep = {
				-- 	actions = {
				-- 		["ctrl-h"] = { actions.toggle_hidden },  -- toggle dotfiles visibility
				-- 		["ctrl-u"] = { actions.toggle_ignore },  -- toggle .gitignore rules
				-- 	},
				-- },
			}
		end,
	},
}
