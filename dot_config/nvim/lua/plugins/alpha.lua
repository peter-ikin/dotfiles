return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set Header
        dashboard.section.header.val = {       
            "                                                ",
            "███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗",
            "████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║",
            "██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║",
            "██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║",
            "██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║",
            "╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
            "                                                ",
        }
        -- Set Menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
            dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fg", "  > Find Word (grep)", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC sr", "󰁯  > Restore Session for Current Directory", "<cmd>AutoSession restore<CR>"), 
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
        }

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
