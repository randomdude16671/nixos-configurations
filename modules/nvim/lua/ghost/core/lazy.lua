return {
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin-mocha" } },
  change_detection = {
    notify = false,
  },
  checker = { enabled = false }, -- DON'T auto check for plugin updates

  ui = {
    icons = {
      ft = " ",
      lazy = "󰂠 ",
      loaded = " ",
      not_loaded = " ",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "editorconfig",
      },
    },
  },
  profiling = {
    loader = true,
    require = true,
  },
}
