return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux", -- Runs tests in a tmux pane
	},
	config = function()
		vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Run all tests in file" })
		vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Run entire test suite" })
		vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Re-run last test" })
		vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>", { desc = "Jump to last test file" })

		vim.cmd("let test#strategy = 'vimux'")
	end,
}
