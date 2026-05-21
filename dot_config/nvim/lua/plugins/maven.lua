return {
  "eatgrass/maven.nvim",
  cmd = { "Maven", "MavenExec" },
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local uname = (vim.uv or vim.loop).os_uname()
    local is_windows = uname.sysname == "Windows_NT"

    require("maven").setup({
      executable = is_windows and "mvn.cmd" or "mvn",
    })
  end,
}
