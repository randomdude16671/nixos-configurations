return {
  "ej-shafran/compile-mode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<C-c><C-o>",
      "<cmd>Compile<cr>",
      desc = "Enter compile mode",
    },
  },
  config = function()
    ---@type CompileModeOptis
    vim.g.compile_mode = {
      default_command = "",
      bang_expansion = true,
    }
  end,
}
