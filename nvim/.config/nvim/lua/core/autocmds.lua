local api = vim.api

-- Highlight yank
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

-- Remember last position
api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = api.nvim_buf_get_mark(0, '"')
		if mark[1] > 1 and mark[1] <= api.nvim_buf_line_count(0) then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Trim whitespace on save
api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Sync terminal background with Neovim background
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if normal.bg then
			io.write(string.format("\027]11;#%06x\027\\", normal.bg))
			io.flush()
		end
	end,
})

vim.api.nvim_create_autocmd("UILeave", {
	callback = function()
		io.write("\027]111\027\\")
		io.flush()
	end,
})
