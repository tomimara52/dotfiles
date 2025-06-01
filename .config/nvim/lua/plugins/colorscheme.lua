return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = true,
        overrides = function(colors)
          return {
            ["@markup.heading.1"] = { bold = true, fg = colors.theme.term[2], underdashed = true},
            ["@markup.heading.2"] = { bold = true, fg = colors.theme.term[3], underdashed = true},
            ["@markup.heading.3"] = { bold = true, fg = colors.theme.term[4], underdashed = true},
            ["@markup.heading.4"] = { bold = true, fg = colors.theme.term[5], underdashed = true},
            ["@markup.heading.5"] = { bold = true, fg = colors.theme.term[6], underdashed = true},
            ["@markup.heading.6"] = { bold = true, fg = colors.theme.term[7], underdashed = true},
          }
        end,
      })

      vim.cmd([[colorscheme kanagawa-dragon]])
    end,
  },
}
