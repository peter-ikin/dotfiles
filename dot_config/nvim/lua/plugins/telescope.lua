return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        ["<C-g>"] = actions.close,
                        ["<C-x>"] = actions.delete_buffer,
                        ["<C-h>"] = actions.select_horizontal,
                    },
                    n = {
                        ["<C-g>"] = actions.close,
                        ["dd"] = actions.delete_buffer,
                    }
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope find recent files (oldfiles)" })
        keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Telescope grep string under cursor" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope help tags" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Telescope find buffers" })
    end,
}
