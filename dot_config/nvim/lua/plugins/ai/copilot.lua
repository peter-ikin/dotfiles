return {
    'github/copilot.vim',
    -- Lazy-loaded: the Copilot language server only starts once you enter insert mode
    event = "InsertEnter",
    cmd = "Copilot",
    init = function()
        -- must be set before the plugin loads to take effect
        vim.g.copilot_no_tab_map = true
    end,
    config = function()
        vim.keymap.set('i', '<C-y>', 'copilot#Accept("")', {
            expr = true,
            replace_keycodes = false
        })
    end
}
