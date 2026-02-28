-- Set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set

-- Window splits
map("n", "<leader>sv", "<cmd>vs<CR>") -- split vertical
map("n", "<leader>sh", "<cmd>sp<CR>") -- split horizontal
map("n", "<leader>sx", "<cmd>close<CR>") -- close current split

-- Navigate splits
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- File operations
map("n", "<Leader>w", "<cmd>w<CR>") -- save
map("n", "<Leader>q", "<cmd>q<CR>") -- quit

-- Search & Clear
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "n", "nzzzv") -- center search next
map("n", "N", "Nzzzv") -- center search prev

-- Visual Selection & Indent
map("n", "<Leader>a", "ggVG") -- select all
map("v", "<", "<gv") -- indent left
map("v", ">", ">gv") -- indent right

-- Move lines (Alt + j/k)
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clipboard
map("v", "<Leader>y", '"+y') -- copy to system clipboard
map("n", "<Leader>p", '"+p') -- paste from system clipboard
map("x", "<Leader>p", '"_dP') -- paste without overwriting clipboard

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>") -- exit terminal mode

-- ===============================
-- Competitive Programming Keymaps
-- ===============================

local function cp_map(mode, lhs, cmd, desc)
	vim.keymap.set(mode, lhs, function()
		vim.cmd("w")
		vim.cmd("cd %:p:h")
		vim.cmd(cmd)
	end, { buffer = true, desc = desc })
end

-- C/C++ keymaps
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- F7 → Clang sanitizer + input
		cp_map(
			{ "n", "i" },
			"<F7>",
			'!clang++ -std=c++17 -Wall -Wextra -Wshadow -fsanitize=address -DONPC -O2 "%" -o "%<" && "./%<" < inp',
			"CP: Clang Sanitize"
		)

		-- F8 → GCC warnings + input
		cp_map(
			{ "n", "i" },
			"<F8>",
			'!g++ -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 "%" -o "%<" && "./%<" < inp',
			"CP: GCC Warnings + Input"
		)
	end,
})

-- F6 → GCC fast compile (no input)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.keymap.set({ "n", "i" }, "<F6>", function()
			vim.cmd("w")
			vim.cmd("cd %:p:h")
			vim.cmd("split")
			vim.cmd("terminal g++ -std=c++17 -DONPC -O2 % -o %< && ./%<")
			vim.cmd("startinsert")
		end, { buffer = true, desc = "CP: GCC Fast" })
	end,
})

-- Python keymap
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set({ "n", "i" }, "<F8>", function()
			vim.cmd("w")
			vim.cmd("!python3 %")
		end, { buffer = true, desc = "Run Python" })
	end,
})
