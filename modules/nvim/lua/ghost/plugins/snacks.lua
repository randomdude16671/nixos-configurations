return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    return {
      input = {
        enabled = true,
      },
      picker = {
        enabled = true,
        layout = "vertical",
        matcher = {
          frecency = true,
        },
      },
      rename = { enabled = true },
      bigfile = { enabled = true },
      indent = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            {
              icon = " ",
              key = "f",
              desc = "Search files",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "s",
              desc = "Show NixOS logo",
              action = ":terminal ~/.config/nvim/logo.sh",
            },
          },
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "keys", section = "keys", indent = 2, padding = 1 },
          { icon = "  ", section = "startup" },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      terminal = { enabled = true },
    }
  end,
  keys = {
    {
      "<leader>f",
      function()
        Snacks.picker.files()
      end,
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.man()
      end,
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.lsp_references()
      end,
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.keymaps()
      end,
    },
    {
      "<leader>si",
      function()
        Snacks.picker.grep_word()
      end,
    },
    {
      "<leader>st",
      function()
        Snacks.picker.pick()
      end,
    },
    {
      "<leader>sp",
      function()
        require("ghost.picker").file_browser("")
      end,
    },
    {
      "<leader>so",
      function()
        Snacks.picker.recent()
      end,
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
    },
  },
}
