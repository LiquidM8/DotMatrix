-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local mygroup = augroup("UserTemplates", { clear = true })

autocmd("BufNewFile", {
    group = mygroup,
    pattern = "*.py",
    callback = function()
        local template = vim.fn.expand("~/.config/nvim/templates/python.py")
        if vim.fn.filereadable(template) == 1 then
            local lines = vim.fn.readfile(template)
            local date = os.date("%Y-%m-%d")
            for i, line in ipairs(lines) do
                lines[i] = line:gsub("<date>", date)
            end
            vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
            vim.cmd("normal! G")
        end
    end,
})
