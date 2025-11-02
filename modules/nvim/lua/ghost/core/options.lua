-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cursor settings
vim.o.cursorline = true
vim.o.cursorlineopt = "number"

-- GUI cursor
vim.o.guicursor = ""

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 2
vim.o.ruler = true

-- Tabs and indentation
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true

-- Search behavior
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- UI settings
vim.opt.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.laststatus = 2
vim.o.showmode = true
vim.o.mouse = "a"
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.o.splitbelow = true
vim.o.splitright = true

-- Performance
vim.o.timeoutlen = 400
vim.opt.updatetime = 50

-- Files and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.o.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- Completion
vim.opt.completeopt = { "menuone", "noselect" }

-- Movement wrapping
vim.opt.whichwrap:append("<>[]hl")

-- Netrw settings (added BACK recently)
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0

-- Disable unnecessary providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
