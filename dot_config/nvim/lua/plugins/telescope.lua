return {
    "nvim-telescope/telescope.nvim",
    -- Lazy-loaded on :Telescope (used by alpha + LSP keymaps) or the <leader>f keymaps
    cmd = "Telescope",
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Telescope find recent files (oldfiles)" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
        { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Telescope grep string under cursor" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope find buffers" },
    },
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
                preview = {
                    treesitter = false,
                },
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
    end,
}
