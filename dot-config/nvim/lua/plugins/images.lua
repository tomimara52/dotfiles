
return {
  "3rd/image.nvim",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter',
    }
  },
  opts = {
    backend = "kitty",
    kitty_method = "normal",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        floating_windows = true, -- if true, images will be rendered in floating markdown windows
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
      },
    },
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = {},
  },
  keys = {
    { "<leader>ie", function() require('image').enable() end },
    { "<leader>id", function() require('image').disable() end },
  }
}
