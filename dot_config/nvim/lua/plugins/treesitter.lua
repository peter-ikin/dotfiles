return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        require("nvim-treesitter").install({
            "json", "javascript", "typescript", "tsx", "yaml", "html",
            "markdown", "markdown_inline", "graphql", "bash", "lua", "vim",
            "dockerfile", "gitignore", "query", "vimdoc", "c", "java", "cpp",
            "c_sharp", "clojure", "cmake", "go", "jsdoc", "kotlin", "perl",
            "powershell", "python", "r", "regex", "toml", "zig",
        })

        require("nvim-ts-autotag").setup()

        -- nvim-treesitter (main branch) no longer enables highlighting itself:
        -- start it for any buffer whose language has an installed parser.
        -- Very large files are skipped to keep editing responsive.
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("UserTreesitterHighlight", { clear = true }),
            callback = function(args)
                local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
                if stat and stat.size > 1024 * 1024 then return end
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
