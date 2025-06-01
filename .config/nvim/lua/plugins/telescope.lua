return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
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

      vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Telescope find neovim buffer" })
    end,
}
