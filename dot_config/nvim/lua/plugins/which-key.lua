return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons" },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        spec = {
            { "<leader>c", group = "Code / AI Cli" },
            { "<leader>d", group = "Debug / Diagnostics" },
            { "<leader>e", group = "Explorer" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Go to" },
            { "<leader>j", group = "Java" },
            { "<leader>q", group = "Quit" },
            { "<leader>r", group = "Rename / Restart" },
            { "<leader>s", group = "Sessions" },
            { "<leader>t", group = "Tests" },
            { "<leader>T", group = "Tabs " },
            { "<leader>w", group = "Windows" },
        },
    },
}
