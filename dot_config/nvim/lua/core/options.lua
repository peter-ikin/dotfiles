vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- line numbers
opt.relativenumber = true -- use relative line numbers
opt.number = true -- with relativenumber on will show the absolute line number on cursor line

-- tabs and indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- cursor line
opt.cursorline = true -- highlight the current line that the cursor is on

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.scrolloff = 10

