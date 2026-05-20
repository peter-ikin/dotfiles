vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set({"i","v","n"}, "<C-g>", "<ESC>", { desc = "Exit insert mode with Ctrl-g" })

-- manage windows
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>ww", "<C-w>w", { desc = "Cycle through window splits" })
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current window split" })

-- manage tabs
keymap.set("n", "<leader>To", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>Tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>Tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>Tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>Tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- convenience shortcuts
keymap.set("n", "<leader>==", "gg=G``", { desc = "Autoformat entire buffer" }) -- autoformat entire buffer
keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Toggle Claude Code' })
keymap.set("t", "<C-g>", "<C-\\><C-n>", { desc = "swap to Normal mode from terminal mode"})

-- quit
keymap.set("n", "<leader>qa", "<cmd>qa<CR>",  { desc = "Quit all (prompts on unsaved)" })
keymap.set("n", "<leader>qA", "<cmd>qa!<CR>", { desc = "Quit all (force, discard changes)" })
keymap.set("n", "<leader>qw", "<cmd>xa<CR>",  { desc = "Write all and quit" })
