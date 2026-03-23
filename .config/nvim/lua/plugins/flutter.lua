return {
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("flutter-tools").setup({
                lsp = {
                    color = {
                        enabled = true,
                    },
                },
                widget_guides = {
                    enabled = true,
                },
                dev_log = {
                    enabled = true,
                    open_cmd = "botright 12split",
                },
            })

            -- Flutter workflow keymaps
            vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterRun<CR>", { desc = "[F]lutter [R]un" })
            vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterReload<CR>", { desc = "[F]lutter Re[l]oad" })
            vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>", { desc = "[F]lutter [R]estart" })
            vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<CR>", { desc = "[F]lutter [Q]uit" })
            vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<CR>", { desc = "[F]lutter [D]evices" })
            vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>", { desc = "[F]lutter [E]mulators" })
            vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>", { desc = "[F]lutter [O]utline" })
            vim.keymap.set("n", "<leader>Fp", "<cmd>Telescope flutter commands<CR>", { desc = "[F]lutter Command [P]alette" })
        end,
    },
}
