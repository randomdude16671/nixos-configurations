-- disable arrow keys
vim.keymap.set("i", "<Up>", "<Nop>")
vim.keymap.set("i", "<Right>", "<Nop>")
vim.keymap.set("i", "<Down>", "<Nop>")
vim.keymap.set("i", "<Left>", "<Nop>")
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("v", "<Up>", "<Nop>")
vim.keymap.set("v", "<Right>", "<Nop>")
vim.keymap.set("v", "<Down>", "<Nop>")
vim.keymap.set("v", "<Left>", "<Nop>")

-- other remaps
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("v", "<C-c>", '"+y', { noremap = true })

vim.keymap.set("n", "<leader>v", "<cmd>vsp | wincmd l<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>sp | wincmd j<cr>")

vim.keymap.set("n", "-", vim.cmd.Ex)
vim.keymap.set("n", "<leader>j", function()
  local line = vim.api.nvim_get_current_line()
  local chunk = "return " .. line
  local f, err = load(chunk)
  if not f then
    f, err = load(line) -- try as statement
  end
  local ok, result = pcall(f)
  if ok then
    print(vim.inspect(result))
  else
    print("Error:", result or err)
  end
end, { desc = "Eval Lua expression" })

vim.keymap.set({ "i", "n" }, "<C-e>", "<cmd>e#<cr>")
vim.keymap.set("n", "<leader>w", "<cmd>update<cr>")
