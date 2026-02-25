return {
	{
		"xeluxee/competitest.nvim",
		dependencies = "muniftanjim/nui.nvim",
		config = function()
			local competitest = require("competitest")
			competitest.setup({
				-- each problem gets its own folder: cp/Codeforces/A.
				received_problems_path = vim.fn.expand("~") .. "/Desktop/cp/$(JUDGE)/$(PROBLEM)/$(PROBLEM).$(FEXT)",
				received_contests_directory = vim.fn.expand("~") .. "/Desktop/cp/$(JUDGE)/$(CONTEST)",
				local_config_file_name = ".competitest.json",
				floating_border = "rounded",
				-- compile with warnings, output binary has same name as file
				compile_command = {
					cpp = { exec = "g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				},
				run_command = {
					cpp = { exec = "./$(FNOEXT)" },
				},
			})

			-- auto create directory when receiving a problem
			vim.api.nvim_create_autocmd("BufNewFile", {
				pattern = vim.fn.expand("~") .. "/Desktop/cp/*",
				callback = function()
					local dir = vim.fn.expand("%:p:h")
					vim.fn.mkdir(dir, "p")
				end,
			})

			vim.keymap.set("n", "<leader>pr", "<cmd>CompetiTest receive problem<CR>", { noremap = true, silent = true }) -- receive from Competitive Companion
			vim.keymap.set("n", "<leader>pc", "<cmd>CompetiTest run<CR>", { noremap = true, silent = true }) -- compile and run against all testcases
			vim.keymap.set("n", "<leader>pa", "<cmd>CompetiTest add_testcase<CR>", { noremap = true, silent = true }) -- add testcase (Ctrl+S to save)
			vim.keymap.set("n", "<leader>pu", "<cmd>CompetiTest show_ui<CR>", { noremap = true, silent = true }) -- open testcase UI
		end,
	},
}
