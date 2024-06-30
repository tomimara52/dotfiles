vim.g.mapleader = ' '

vim.keymap.set("n", "<leader>n", ":NERDTreeToggle<CR>", {noremap = true})

-- Window movements
vim.keymap.set("n", "<leader>wk", ":wincmd k<CR>", {silent = true})
vim.keymap.set("n", "<leader>wj", ":wincmd j<CR>", {silent = true})
vim.keymap.set("n", "<leader>wh", ":wincmd h<CR>", {silent = true})
vim.keymap.set("n", "<leader>wl", ":wincmd l<CR>", {silent = true})

-- Window resizing
vim.keymap.set("n", "<leader>w+", "<C-w>+", {silent = true, remap = true})
vim.keymap.set("n", "<leader>w-", "<C-w>-", {silent = true, remap = true})
vim.keymap.set("n", "<leader>w}", "<C-w>>", {silent = true, remap = true})
vim.keymap.set("n", "<leader>w{", "<C-w><", {silent = true, remap = true})
vim.keymap.set("n", "<leader>w=", "<C-w>=", {silent = true, remap = true})

-- Tab switching
vim.keymap.set("n", "<leader>gn", "gt", {silent = true})
vim.keymap.set("n", "<leader>gp", "gT", {silent = true})

-- File finding with fzf
vim.keymap.set("n", "<leader>fg", ":GFiles<CR>", {noremap = true})
vim.keymap.set("n", "<leader>ff", ":Files<CR>", {noremap = true})
vim.keymap.set("n", "<leader>fr", ":Rg<CR>", {noremap = true})

-- Save and exit commands
vim.keymap.set("n", "<leader>s", ":w<CR>")
vim.keymap.set("n", "<leader>S", ":wq<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

-- Buffer commands
vim.keymap.set("n", "<leader>bd", ":bd ")
vim.keymap.set("n", "<leader>bb", ":Buffers<CR>")

vim.keymap.set("n", "<leader>e", ":edit ")

vim.keymap.set("n", "<leader>m", ":Neogit<CR>")

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")
