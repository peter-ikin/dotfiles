return {
    "greggh/claude-code.nvim",
    -- Lazy-loaded: <leader>cc (core/keymaps.lua) runs :ClaudeCode, which loads it
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose", "ClaudeCodeVersion" },
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
        require("claude-code").setup({
            window = {
                position = "botright",
            },
            keymaps = {

            }
        })
    end
}
