return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        config = function()
            require("lazywave.plugins.configs.lualine")
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,  -- load first so everything else gets the palette
        lazy = false,     -- load at startup
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings   = true,
                    emphasis  = true,
                    comments  = true,
                    operators = false,
                    folds     = true,
                },
                strikethrough     = true,
                invert_selection  = false,
                invert_signs      = false,
                invert_tabline    = false,
                inverse           = true,
                contrast          = "",      -- "hard", "soft", or ""
                palette_overrides = {},
                overrides         = {},
                dim_inactive      = false,
                transparent_mode  = true,
            })
            vim.cmd("colorscheme gruvbox")

            -- hover-window style (Runs after palette is active)
            require("lazywave.core.float")
        end,
    },
}
