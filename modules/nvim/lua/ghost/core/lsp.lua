vim.lsp.enable({
  "tinymist",
  "gopls",
  "nixd",
  "lua_ls",
  "pyright",
  "clangd",
  "ts_ls",
  "rust_analyzer",
})

vim.diagnostic.config({
  virtual_text = {
    enabled = true,
  },
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = require("ghost.core.icons").diagnostics.Error,
      [vim.diagnostic.severity.WARN] = require("ghost.core.icons").diagnostics.Warn,
      [vim.diagnostic.severity.HINT] = require("ghost.core.icons").diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = require("ghost.core.icons").diagnostics.Info,
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Lsp Keymaps",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local opts = function(desc)
      return { noremap = true, silent = true, buffer = event.buf, desc = desc }
    end
    local keymaps = {
      { "n", "gd", vim.lsp.buf.definition, "Go to Definition" },
      { "n", "gD", vim.lsp.buf.declaration, "Go to Declaration" },
      { "n", "gr", vim.lsp.buf.references, "Find References" },
      { "n", "gi", vim.lsp.buf.implementation, "Go to Implementation" },
      { "n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition" },
      { "n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder" },
      { "n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder" },
      {
        "n",
        "<leader>wl",
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        "List Workspace Folders",
      },
      { "n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol" },
      {
        "n",
        "<leader>lo",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        "Format Code",
      },
      { "n", "<leader>e", vim.diagnostic.open_float, "Show Diagnostic" },
      { "n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic Quickfix" },
      { "n", "<leader>li", "<cmd>LspInfo<CR>", "LSP Info" },
    }

    for _, map in ipairs(keymaps) do
      vim.keymap.set(map[1], map[2], map[3], opts(map[4]))
    end
    if client ~= nil then
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
      end
    end
  end,
})
