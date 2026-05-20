-- Neotest configuration for Java/Maven testing
-- Add this to your Neovim configuration (e.g., ~/.config/nvim/lua/plugins/neotest.lua)

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
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

    -- Key mappings for test running
    local neotest = require("neotest")
    
    -- Run the nearest test
    vim.keymap.set("n", "<leader>tn", function()
      neotest.run.run()
    end, { desc = "Run nearest test" })
    
    -- Run the current file
    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current test file" })
    
    -- Run all tests
    vim.keymap.set("n", "<leader>ta", function()
      neotest.run.run(vim.fn.getcwd())
    end, { desc = "Run all tests" })
    
    -- Debug the nearest test (requires nvim-dap)
    vim.keymap.set("n", "<leader>td", function()
      neotest.run.run({ strategy = "dap" })
    end, { desc = "Debug nearest test" })
    
    -- Toggle test summary window
    vim.keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, { desc = "Toggle test summary" })
    
    -- Toggle test output panel
    vim.keymap.set("n", "<leader>to", function()
      neotest.output_panel.toggle()
    end, { desc = "Toggle test output" })
    
    -- Show output of nearest test
    vim.keymap.set("n", "<leader>tO", function()
      neotest.output.open({ enter = true })
    end, { desc = "Show test output" })
    
    -- Stop running tests
    vim.keymap.set("n", "<leader>tS", function()
      neotest.run.stop()
    end, { desc = "Stop tests" })
  end,
}
