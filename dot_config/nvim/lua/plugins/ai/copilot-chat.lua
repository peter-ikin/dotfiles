return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        -- Lazy-loaded on <leader>cp or any :CopilotChat* command
        cmd = {
            "CopilotChat", "CopilotChatOpen", "CopilotChatToggle", "CopilotChatClose",
            "CopilotChatExplain", "CopilotChatReview", "CopilotChatFix", "CopilotChatOptimize",
            "CopilotChatDocs", "CopilotChatTests", "CopilotChatCommit", "CopilotChatModels",
            "CopilotChatPrompts", "CopilotChatLoad", "CopilotChatSave", "CopilotChatReset", "CopilotChatStop",
        },
        keys = {
            { "<leader>cp", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
        },
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        config = function()
            require("CopilotChat").setup({
                window = {
                    layout = "vertical",
                },
            })

            -- Move Copilot Chat to the right when it opens
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "copilot-chat",
                callback = function()
                    vim.cmd("wincmd L") -- Move the window to the far right
                end,
            })

            vim.api.nvim_create_autocmd("BufWinEnter", {
                callback = function()
                    local bufname = vim.api.nvim_buf_get_name(0)
                    if bufname:match("copilot") then
                        vim.cmd("wincmd L") -- Move the window to the far right
                    end
                end,
            })
        end,
    },
}
