local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" }, { import = "plugins.ai"} }, {
    checker = {
        enabled = true,
        notify = false,
        frequency = 86400, -- check for plugin updates once a day (default is hourly)
    },
    performance = {
        rtp = {
            -- built-in plugins that aren't used (nvim-tree replaces netrw)
            disabled_plugins = { "gzip", "tarPlugin", "netrwPlugin", "tohtml", "tutor" },
        },
    },
    change_detection = {
        notify = false,
    },
})
