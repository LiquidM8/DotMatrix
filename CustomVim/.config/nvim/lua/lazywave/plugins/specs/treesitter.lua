return {
  {
    "nvim-treesitter/nvim-treesitter",
    build  = ":TSUpdate",
    lazy   = false,
    config = function()
      require("lazywave.plugins.configs.treesitter")
    end,
  },
}
