return {
	-- gitsigns: Git status in gutter (adds │ for changes, _ for deletions)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					-- Navigation between changes
					vim.keymap.set("n", "]c", function()
						gitsigns.next_hunk()
					end, { buffer = bufnr, desc = "Next hunk" })
					vim.keymap.set("n", "[c", function()
						gitsigns.prev_hunk()
					end, { buffer = bufnr, desc = "Prev hunk" })

					-- Stage/undo individual hunks
					vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
					vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
					vim.keymap.set("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { buffer = bufnr, desc = "Stage hunk" })

					-- Blame line and file diff
					vim.keymap.set("n", "<leader>hb", gitsigns.blame_line, { buffer = bufnr, desc = "Blame line" })
					vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Diff this" })
				end,
			})
		end,
	},

	-- fugitive: Git commands from within Neovim (status, diff)
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gstatus" },
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff" },
		},
	},

	-- lazygit: Full Git TUI for complex operations (commit, push, rebase)
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
		},
		cond = function()
			return vim.fn.executable("lazygit") == 1
		end,
	},
}
