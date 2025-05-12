return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      --vim.cmd([[colorscheme kanagawa-dragon]])
    end,
  },
  {
    'miikanissi/modus-themes.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme modus_vivendi]])
    end,
  },
}
