return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore = false,
            suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop/" },
            bypass_save_filetypes = { "NvimTree" },
            post_restore_cmds = { function()
                vim.schedule(function()
                    require("nvim-tree.api").tree.open()
                end)
            end },
        })

        local keymap = vim.keymap

        keymap.set("n", "<leader>sr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" })
        keymap.set("n", "<leader>ss", "<cmd>AutoSession save<CR>", { desc = "Save session" })
    end,
}
