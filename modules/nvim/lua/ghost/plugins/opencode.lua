return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `toggle()`.
    { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
  },
  config = function()
    vim.o.autoread = true
    vim.g.opencode_opts = {
      auto_reload = true,
    }
  end,
  keys = {
    {
      "<leader>oa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
    },
    {
      "<leader>os",
      function()
        require("opencode").select()
      end,
    },
    {
      "<leader>o+",
      function()
        require("opencode").prompt("@this")
      end,
    },
    {
      "<leader>ot",
      function()
        require("opencode").toggle()
      end,
    },
    {
      "<leader>oc",
      function()
        require("opencode").command()
      end,
    },
    {
      "<leader>on",
      function()
        require("opencode").command("session_new")
      end,
    },
    {
      "<leader>oi",
      function()
        require("opencode").command("session_interrupt")
      end,
    },
    {
      "<leader>oA",
      function()
        require("opencode").command("agent_cycle")
      end,
    },
    {
      "<S-C-u>",
      function()
        require("opencode").command("messages_half_page_up")
      end,
    },
    {
      "<S-C-d>",
      function()
        require("opencode").command("messages_half_page_down")
      end,
    },
  },
}
