-- This code is kinda bad. I hallucinated this code when I was sleeping.
local M = {}

function M.file_browser(start_dir)
  local uv = vim.loop

  -- Defaults
  local opts = {
    keymaps = {
      enter = "<C-l>",
      back = "<C-h>",
      confirm = "<CR>",
    },
    icons = {
      enabled = true,
      dir = " ",
      file = " ",
    },
    show_hidden = false,
    sort_directories_first = true,
  }

  local function show_dir(dir)
    local entries = {}

    -- Add parent dir
    if dir ~= "/" and dir ~= "\\" and not dir:match("^%a:[\\/]?$") then
      table.insert(entries, {
        text = "../",
        file = vim.fn.fnamemodify(dir, ":h"),
        dir = true,
      })
    end

    local handle = uv.fs_scandir(dir)
    if handle then
      while true do
        local name, type = uv.fs_scandir_next(handle)
        if not name then
          break
        end

        if opts.show_hidden or not name:match("^%.") then
          local full_path = dir .. (dir:match("[\\/]$") and "" or "/") .. name
          local is_dir = type == "directory" or (type == "link" and vim.fn.isdirectory(full_path) == 1)

          local icon = ""
          if opts.icons.enabled then
            icon = is_dir and opts.icons.dir .. " " or opts.icons.file .. " "
          end

          table.insert(entries, {
            text = icon .. name,
            file = full_path,
            dir = is_dir,
          })
        end
      end
    end

    -- Sorting
    table.sort(entries, function(a, b)
      if opts.sort_directories_first and a.dir ~= b.dir then
        return a.dir
      end
      return a.text < b.text
    end)

    -- Keymaps
    local keys = {}
    keys[opts.keymaps.enter] = { "browse_enter", mode = { "n", "i" } }
    keys[opts.keymaps.back] = { "browse_back", mode = { "n", "i" } }
    if opts.keymaps.confirm ~= opts.keymaps.enter then
      keys[opts.keymaps.confirm] = { "browse_enter", mode = { "n", "i" } }
    end

    require("snacks").picker({
      title = "File Browser: " .. dir,
      items = entries,
      actions = {
        browse_enter = function(picker, item)
          if item then
            picker:close()
            if item.dir then
              show_dir(item.file)
            else
              vim.cmd("edit " .. vim.fn.fnameescape(item.file))
            end
          end
        end,
        browse_back = function(picker, _)
          local parent = vim.fn.fnamemodify(dir, ":h")
          if parent ~= dir then
            picker:close()
            show_dir(parent)
          end
        end,
      },
      win = { input = { keys = keys } },
    })
  end

  local start = start_dir or vim.fn.expand("%:p:h")
  if start == "" then
    start = uv.cwd()
  end
  show_dir(start)
end

return M
