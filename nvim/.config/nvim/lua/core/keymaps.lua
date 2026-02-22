-- Set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Tabs
map("n", "<Leader>tn", "<cmd>tabnew<CR>")
map("n", "<F1>", "<cmd>tabprev<CR>")
map("n", "<F2>", "<cmd>tabnext<CR>")

-- Window Splits
map("n", "<Leader>v", "<cmd>vs<CR>")
map("n", "<Leader>h", "<C-w>h")
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")
map("n", "<Leader>l", "<C-w>l")

-- Buffers Navigation
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprevious<CR>")
map("n", "<Leader>bd", "<cmd>bdelete<CR>")

-- File operations
map("n", "<Leader>w", "<cmd>w<CR>")
map("n", "<Leader>q", "<cmd>q<CR>")
map("n", "<Leader>e", "<cmd>Ex<CR>")
map("n", "<Leader>s", "<cmd>source $MYVIMRC<CR>")

-- Search & Clear
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights" })
map("n", "n", "nzzzv", { desc = "Center search next" })
map("n", "N", "Nzzzv", { desc = "Center search prev" })

-- Visual Selection & Indent
map("n", "<Leader>a", "ggVG", { desc = "Select all" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines (Alt + j/k)
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clipboard
map("v", "<Leader>y", '"+y')
map("n", "<Leader>p", '"+p')
map("x", "<Leader>p", '"_dP')

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>")
