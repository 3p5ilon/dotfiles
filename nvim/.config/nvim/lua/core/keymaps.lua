local map = vim.keymap.set

-- Fast insert mode escape
map("i", "jk", "<Esc>", { silent = true, desc = "Exit insert mode" })

-- Window splits & navigation
map("n", "<leader>-", "<c-w>s", { desc = "Split below" })
map("n", "<leader>|", "<c-w>v", { desc = "Split right" })
map("n", "<leader>wd", "<c-w>c", { desc = "Close window" })
map("n", "<c-h>", "<c-w>h", { desc = "Focus left window" })
map("n", "<c-j>", "<c-w>j", { desc = "Focus lower window" })
map("n", "<c-k>", "<c-w>k", { desc = "Focus upper window" })
map("n", "<c-l>", "<c-w>l", { desc = "Focus right window" })

-- File operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>noa w<cr>", { desc = "Save without formatting" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit Neovim" })

-- Viewport & cursor stability
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })
map("n", "n", "nzzzv", { desc = "Next search match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search match (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "J", "mzJ`z", { desc = "Join lines (preserve cursor)" })

-- Line & block movement
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move block down", silent = true })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move block up", silent = true })

-- Visual mode indentation
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- Registers & clipboard
map("n", "<leader>a", "ggVG", { desc = "Select all text" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without copying" })
map("x", "<leader>p", '"_dP', { desc = "Paste over selection (keep register)" })

-- Native quickfix navigation
map("n", "[q", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })
map("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })

-- Terminal mode
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- Buffer-only rename 
map("n", "<leader>rb", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename in current buffer" })

-- Load cp utilities
-- require("utils.cp")
