vim.loader.enable() -- speed up lua module loading

require("ghost.core")

local keymaps_path = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "ghost", "core", "keymaps.lua")
vim.cmd.so(keymaps_path)

require("lazy").setup({
  { import = "ghost.plugins" },
}, require("ghost.core.lazy"))
