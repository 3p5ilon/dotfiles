-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set

-- Window splits
map("n", "<leader>-", "<c-w>s", { desc = "split below" })
map("n", "<leader>|", "<c-w>v", { desc = "split right" })
map("n", "<leader>wd", "<c-w>c", { desc = "close window" })

-- navigate splits
map("n", "<c-h>", "<c-w>h", { desc = "window left" })
map("n", "<c-j>", "<c-w>j", { desc = "window down" })
map("n", "<c-k>", "<c-w>k", { desc = "window up" })
map("n", "<c-l>", "<c-w>l", { desc = "window right" })

-- File operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "quit" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })

-- Search
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search" })
map("n", "n", "nzzzv", { desc = "next result" })
map("n", "N", "Nzzzv", { desc = "prev result" })

-- Visual mode
map("n", "<leader>a", "ggvg", { desc = "select all" })
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

-- Line movement
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "line down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "line up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "lines down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "lines up" })

-- Clipboard
map("v", "<leader>y", '"+y', { desc = "copy to system" })
map("n", "<leader>p", '"+p', { desc = "paste from system" })
map("x", "<leader>p", '"_dp', { desc = "paste (no overwrite)" })

-- Terminal
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal" })

-- Load cp utilities
require("utils.cp")
