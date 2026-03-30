return {
  "yetone/avante.nvim",
  enabled = false,
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    -- instructions_file = "avante.md",
    -- for example
    provider = "gemini-cli",
    acp_providers = {
        ["gemini-cli"] = {
        command = "gemini",
        args = { "--experimental-acp", "--model", "gemini-2.5-flash" },
        env = {
          NODE_NO_WARNINGS = "1",
          GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
        },
      },
    },
    behaviour = {
      auto_approve_tool_permissions = false,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}
