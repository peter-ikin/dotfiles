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
    end,
}
