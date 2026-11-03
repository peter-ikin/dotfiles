-- Neotest configuration for Java/Maven testing
-- Lazy-loaded: loads on first use of a <leader>t mapping or :Neotest

local function nt() return require("neotest") end

return {
  "nvim-neotest/neotest",
  cmd = { "Neotest", "NeotestJava" },
  keys = {
    { "<leader>tn", function() nt().run.run() end, desc = "Run nearest test" },
    { "<leader>tf", function() nt().run.run(vim.fn.expand("%")) end, desc = "Run current test file" },
    { "<leader>ta", function() nt().run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
    { "<leader>td", function() nt().run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    { "<leader>ts", function() nt().summary.toggle() end, desc = "Toggle test summary" },
    { "<leader>to", function() nt().output_panel.toggle() end, desc = "Toggle test output" },
    { "<leader>tO", function() nt().output.open({ enter = true }) end, desc = "Show test output" },
    { "<leader>tS", function() nt().run.stop() end, desc = "Stop tests" },
  },
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Java test adapter
    "rcasia/neotest-java",
    "mfussenegger/nvim-jdtls",
    -- Debugging
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-java")({
          -- Optional: specify junit jar path if not auto-detected
          -- junit_jar = "/path/to/junit-platform-console-standalone.jar",
          -- Use Maven for running tests
          runner = "maven",
        }),
      },
      -- Optional: customize the test output
      output = {
        enabled = true,
        open_on_run = true,
      },
      -- Optional: show test status in sign column
      status = {
        enabled = true,
        virtual_text = true,
        signs = true,
      },
      -- Optional: floating window for test output
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      -- Optional: test summary window
      summary = {
        enabled = true,
        expand_errors = true,
        follow = true,
        mappings = {
          attach = "a",
          clear_marked = "M",
          clear_target = "T",
          debug = "d",
          debug_marked = "D",
          expand = { "<CR>", "<2-LeftMouse>" },
          expand_all = "e",
          jumpto = "i",
          mark = "m",
          next_failed = "J",
          output = "o",
          prev_failed = "K",
          run = "r",
          run_marked = "R",
          short = "O",
          stop = "u",
          target = "t",
        },
      },
    })
  end,
}
