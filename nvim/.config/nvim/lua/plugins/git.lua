return {
	-- Gitsigns: Asynchronous gutter diagnostics & hunk management
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				-- Context-aware Hunk Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next hunk")

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev hunk")

				-- Actions (Normal & Visual)
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage selected hunk")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset selected hunk")

				map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

				-- Previews & Blame
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hP", gs.preview_hunk_inline, "Preview hunk inline")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>hd", gs.diffthis, "Diff this")
			end,
		},
	},

	-- Vim-Fugitive
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gdiffsplit" },
		keys = {
			{ "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
			{ "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff" },
			{ "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
			{ "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
		},
	},

	-- LazyGit Terminal Integration
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
		},
		cond = function()
			return vim.fn.executable("lazygit") == 1
		end,
	},
}
