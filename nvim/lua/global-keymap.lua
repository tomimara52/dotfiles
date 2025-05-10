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

-- File finding with telescope
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = "move_selection_previous",
        ["<C-j>"] = "move_selection_next",
      }
    }
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope find git files" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files in directory" })
vim.keymap.set("n", "<leader>fr", builtin.live_grep, { desc = "Telescope find string ignoring .gitignore" })

-- Save and exit commands
vim.keymap.set("n", "<leader>s", ":w<CR>")
vim.keymap.set("n", "<leader>S", ":wq<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

-- Buffer commands
vim.keymap.set("n", "<leader>bd", ":bd ")
vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Telescope find neovim buffer" })

vim.keymap.set("n", "<leader>e", ":edit ")

vim.keymap.set("n", "<leader>m", ":Neogit<CR>")

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

vim.cmd([[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'

imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]])
