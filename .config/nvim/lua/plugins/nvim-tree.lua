return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local api = require("nvim-tree.api")

        local function on_attach(bufnr)
            api.config.mappings.default_on_attach(bufnr)

            local function open_file_or_expand()
                local node = api.tree.get_node_under_cursor()
                if not node then
                    return
                end

                -- Keep folder behavior intuitive; files open in current window.
                if node.type == "directory" or node.nodes ~= nil then
                    api.node.open.edit()
                    return
                end

                api.node.open.edit()
            end

            vim.keymap.set("n", "<CR>", open_file_or_expand, {
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
                desc = "Open file",
            })

            vim.keymap.set("n", "o", open_file_or_expand, {
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
                desc = "Open file",
            })

            vim.keymap.set("n", "<2-LeftMouse>", open_file_or_expand, {
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
                desc = "Open file",
            })

            vim.keymap.set("n", "t", api.node.open.tab, {
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
                desc = "Open file in new tab",
            })
        end

        require("nvim-tree").setup({
            on_attach = on_attach,
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            view = {
                width = 36,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
        })

        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer Toggle" })
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFocus<CR>", { desc = "[E]xplorer [F]ocus" })
        vim.keymap.set("n", "<leader>eo", "<cmd>NvimTreeFindFile<CR>", { desc = "[E]xplorer Find File" })

        -- Auto-open tree when launching nvim with a directory argument, e.g. nvim .
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                if vim.fn.isdirectory(data.file) == 1 then
                    vim.cmd.cd(data.file)
                    api.tree.open()
                end
            end,
        })
    end,
}
