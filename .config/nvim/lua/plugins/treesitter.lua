return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "VeryLazy" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = { 'python', },
    },
    ensure_installed = {
      "bash",
      "c",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "vim",
      "toml",
      "vimdoc",
      "yaml",
      "html",
      "json",
      "lua",
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end
}
