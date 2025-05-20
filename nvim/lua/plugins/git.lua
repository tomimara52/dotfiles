return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    {
      "<leader>m", ":Neogit<CR>", "Open a NeogitStatus tab"
    }
  }
}
