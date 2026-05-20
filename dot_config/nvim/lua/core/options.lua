local opt = vim.opt

-- clipboard
opt.clipboard = "unnamedplus"

-- line numbers
opt.relativenumber = true -- use relative line numbers
opt.number = true -- with relativenumber on will show the absolute line number on cursor line

-- tabs and indents
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- splits
opt.splitright = true
opt.splitbelow = true

-- session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- line wrapping
opt.wrap = false

-- cursor line
opt.cursorline = true -- highlight the current line that the cursor is on

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- searching
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- ... unless you type a captial letter


-- misc
opt.backspace = "indent,eol,start"
opt.scrolloff = 10
opt.undofile = true -- persist undo history across sessions
opt.confirm = true -- prompt to save unsaved changes instead of erroring on :q / :qa

-- disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
