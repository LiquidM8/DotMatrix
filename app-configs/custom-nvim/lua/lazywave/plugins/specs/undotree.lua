return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeFocus" },
        keys = {
            { "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Undo-tree toggle" },
            { "<leader>uf", "<cmd>UndotreeFocus<CR>",  desc = "Undo-tree focus" },
        },
        init = function()
            -- optional: tweak default layout so the tree opens on the right
            vim.g.undotree_WindowLayout = 3
        end,
    },
}
