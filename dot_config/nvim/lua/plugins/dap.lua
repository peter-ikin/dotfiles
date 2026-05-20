return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("nvim-dap-virtual-text").setup()

            dapui.setup()

            -- Auto open/close DAP UI when debugging starts/ends
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Keymaps
            local keymap = vim.keymap
            keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
            keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
            keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
            keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
            keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
            keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
        end,
    },
}
