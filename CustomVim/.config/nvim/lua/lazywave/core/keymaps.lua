vim.g.mapleader = " "

-- Opens NetRW view
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Resizing Windows
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", { desc = "Expand window horizontally" })
vim.keymap.set("n", "<A-Up>", ":resize -2<CR>", { desc = "Expand window vertically" })
vim.keymap.set("n", "<A-Down>", ":resize +2<CR>", { desc = "Shrink window vertically" })

-- Tree-sitter Playground keymaps
vim.keymap.set("n", "<leader>hi", ":Inspect<CR>", { desc = "Show highlight groups under cursor" })
vim.keymap.set("n", "<leader>ht", ":InspectTree<CR>", { desc = "Show syntax tree (TSPlayground)" })
vim.keymap.set("n", "<leader>hq", ":EditQuery<CR>", { desc = "Open Tree-sitter Live Query Editor" })
