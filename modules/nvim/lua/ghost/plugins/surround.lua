return {
  "kylechui/nvim-surround",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("nvim-surround").setup({})
  end,
}
