-- Competitive Programming Setup

-- compile & run helper
local function cp_run(cmd)
	vim.cmd("wall") -- save all files
	vim.cmd("lcd %:p:h") -- run command in file directory
	vim.cmd("!" .. cmd)
end

-- toggle competitive programming layout
local function cp_layout_toggle()
	local inp_win, out_win

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")

		if name == "inp" then
			inp_win = win
		end
		if name == "out" then
			out_win = win
		end
	end

	-- close layout if already open
	if inp_win or out_win then
		if inp_win then
			vim.api.nvim_win_close(inp_win, true)
		end
		if out_win then
			vim.api.nvim_win_close(out_win, true)
		end
		return
	end

	if vim.fn.filereadable("inp") == 0 then
		vim.notify("inp file not found", vim.log.levels.ERROR)
		return

		-- auto-create inp instead of error
		-- vim.cmd("edit inp")
		-- vim.cmd("write")
	end

	if vim.fn.filereadable("out") == 0 then
		vim.notify("out file not found", vim.log.levels.ERROR)
		return

		-- auto-create out instead of error
		-- vim.cmd("edit out")
		-- vim.cmd("write")
	end

	vim.cmd("vsplit inp")

	local total = vim.o.columns
	vim.cmd("vertical resize " .. math.floor(total * 0.4))

	vim.cmd("split out")
	vim.cmd("wincmd h") -- return to code
end

-- auto-save inp/out while editing
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
	pattern = { "inp", "out" },
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent write")
		end
	end,
})

-- C++ keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		-- toggle cp layout (code | inp + out)
		vim.keymap.set("n", "<leader>cp", cp_layout_toggle, {
			buffer = true,
			desc = "CP toggle layout",
		})

		-- clang build with AddressSanitizer (debugging memory errors)
		vim.keymap.set({ "n", "i" }, "<F7>", function()
			cp_run("clang++ -std=c++17 -Wall -Wextra -Wshadow -fsanitize=address -O2 % -o %< && time ./%< < inp > out")
		end, { buffer = true })

		-- gcc build with warnings
		vim.keymap.set({ "n", "i" }, "<F8>", function()
			cp_run("g++ -std=c++17 -Wall -Wextra -Wshadow -O2 % -o %< && time ./%< < inp > out")
		end, { buffer = true })

		-- fast compile
		vim.keymap.set({ "n", "i" }, "<F6>", function()
			vim.cmd("wall")
			vim.cmd("lcd %:p:h")

			local cmd = "g++ -std=c++17 -O2 % -o %< && ./%<"

			vim.cmd("botright split")
			vim.cmd("resize 12")
			vim.cmd("terminal " .. cmd)
			vim.cmd("startinsert")
		end, { buffer = true })
	end,
})

-- Python run
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set({ "n", "i" }, "<F8>", function()
			vim.cmd("wall")
			vim.cmd("!python3 %")
		end, { buffer = true })
	end,
})
