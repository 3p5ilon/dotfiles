-- Set Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<Leader>h", "<C-w>h")
map("n", "<Leader>j", "<C-w>j")
map("n", "<Leader>k", "<C-w>k")
map("n", "<Leader>l", "<C-w>l")
map("n", "<Tab>", "<cmd>bnext<CR>")
map("n", "<S-Tab>", "<cmd>bprevious<CR>")
map("n", "<Leader>bd", "<cmd>bdelete<CR>")

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<F12>", "<cmd>set relativenumber!<CR>")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z") -- Join lines but keep cursor in place

-- Save and Quit
map("n", "<Leader>w", "<cmd>w<CR>")
map("n", "<Leader>q", "<cmd>q<CR>")

-- Visual Mode & Movement
map("n", "<Leader>a", "ggVG")
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines (Alt + j/k)
map("n", "<A-j>", "<cmd>m .+1<CR>==")
map("n", "<A-k>", "<cmd>m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clipboard Management
map("v", "<Leader>y", '"+y') -- Yank to system clipboard
map("n", "<Leader>p", '"+p') -- Paste from system clipboard
map("x", "<Leader>p", '"_dP') -- Paste over selection without losing what you copied

-- System & Config
map("n", "<Leader>e", "<cmd>Ex<CR>")
map("n", "<Leader>v", "<cmd>vs<CR>")
map("n", "<Leader>s", "<cmd>source $MYVIMRC<CR>")
