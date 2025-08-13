return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        cmd = "Mason",
        build = ":MasonUpdate",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "neovim/nvim-lspconfig",
            "nvimtools/none-ls.nvim",
            "gbprod/none-ls-luacheck.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("lazywave.plugins.configs.mason")
        end,
    },
}
