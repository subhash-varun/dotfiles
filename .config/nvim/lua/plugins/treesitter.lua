return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "java",
                "dart",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "json",
                "yaml",
                "toml",
                "xml",
                "markdown",
                "markdown_inline",
                "bash",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
