return {
  "nvimtools/none-ls.nvim",
  event = "LspAttach",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local custom_diagnostics = {
      {
        name = "func-annotation-checker-lua",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = { "lua" },

        generator = {
          fn = function(params)
            local diagnostics = {}
            for i, line in ipairs(params.content) do
              local func_params = line:match("^%s*function%s+[%w%.]+%((.-)%)")
              if func_params and func_params:match("%S") then
                local previous_line = params.content[i - 1] or ""
                if not previous_line:match("^%-%-%-?%s*@param") then
                  table.insert(diagnostics, {
                    row = i,
                    col = 0,
                    end_col = #line,
                    message = "Ghost: Function with No param types? You sure?",
                    severity = 2,
                    source = "ghost-lua-checker-subset",
                  })
                end
              end
            end
            return diagnostics
          end,
        },
      },
    }

    for _, diag in ipairs(custom_diagnostics) do
      null_ls.register({
        name = diag.name,
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = diag.filetypes,
        generator = diag.generator,
      })
    end

    null_ls.setup({
      sources = {
        -- Formatting:
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.nixfmt,
        null_ls.builtins.formatting.clang_format.with({
          filetypes = { "c", "cpp" },
        }),

        -- Linting:
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.diagnostics.statix,

        -- Code actions:
        null_ls.builtins.code_actions.statix,
      },
    })
  end,
}
