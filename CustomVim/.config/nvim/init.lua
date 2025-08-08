-- Required Sources
--require('lazywave')

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load Helper Path
local function load(mod) return require("lazywave." .. mod) end

-- Core Settings | Run on every start-up
load("core.options")
load("core.keymaps")
load("core.autocmds")

-- Loads Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Spin up lazy and imports plugins
require("lazy").setup({
    { import = "lazywave.plugins.specs" },  -- list of plugin specs
}, {
    change_detection = { notify = false },  -- Lazy options
    defaults         = { lazy = true },     -- Lazy options
})
