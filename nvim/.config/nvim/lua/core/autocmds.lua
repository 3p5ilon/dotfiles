local api = vim.api

-- Reusable augroup helper to prevent duplicate triggers on reload
local function augroup(name)
	return api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- Remember last cursor position (skips git & floating buffers)
api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit", "gitrebase", "commit", "oil", "lazy" }
		local ft = api.nvim_get_option_value("filetype", { buf = event.buf })

		if vim.list_contains(exclude, ft) then
			return
		end

		local mark = api.nvim_buf_get_mark(event.buf, '"')
		local lcount = api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Trim whitespace on save (skips markdown, git, and binary files)
api.nvim_create_autocmd("BufWritePre", {
	group = augroup("trim_whitespace"),
	pattern = "*",
	callback = function(event)
		local exclude = { "markdown", "gitcommit", "diff" }
		local ft = api.nvim_get_option_value("filetype", { buf = event.buf })

		if vim.list_contains(exclude, ft) or vim.bo[event.buf].binary then
			return
		end

		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Sync terminal background with Neovim theme
api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	group = augroup("sync_term_bg"),
	callback = function()
		local normal = api.nvim_get_hl(0, { name = "Normal" })
		if normal and normal.bg then
			io.write(string.format("\027]11;#%06x\027\\", normal.bg))
			io.flush()
		end
	end,
})

api.nvim_create_autocmd("UILeave", {
	group = augroup("reset_term_bg"),
	callback = function()
		io.write("\027]111\027\\")
		io.flush()
	end,
})

-- Close help and utility windows with just 'q'
api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = { "help", "lspinfo", "man", "qf", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
