return {
    {
        'nvim-telescope/telescope.nvim',
            dependencies = {'nvim-lua/plenary.nvim'},
        -- Load key-maps
        keys = {
            { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>pg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Git files" },
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    -- Testing Layout
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.55,
                            width = 0.9
                        },
                        vertical = {
                            width = 0.95,
                            height = 0.9,
                            preview_cutoff = 20,
                        },
                        center = {
                            width = 0.50,
                            height = 0.40,
                        },
                    },
                    mappings = {
                        i = { ["<esc>"] = actions.close },
                    }
                },
                pickers = {
                    -- everyday stuff
                    find_files = { theme = "dropdown",
                        previewer = false,
                        hidden = true
                    },
                    live_grep  = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.95,
                            height = 0.9,
                            preview_cutoff = 20
                        },
                    },
                    buffers    = {
                        theme = "ivy",
                        sort_mru = true,
                        ignore_current_buffer = true,
                    }
                },
            }
        end,
    },
}
