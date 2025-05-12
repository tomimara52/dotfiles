return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  config = function()
    vim.keymap.set("n", "<leader>m", ":Neogit<CR>")
  end
}
