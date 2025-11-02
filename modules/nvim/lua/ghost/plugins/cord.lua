return {
  "vyfor/cord.nvim",
  event = { "BufRead", "BufNewFile" },
  build = ":Cord update",
  opts = {},
}
