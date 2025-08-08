-- Overall Mason Setup and Config
require('mason').setup({
    log_level = vim.log.levels.DEBUG,
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Mason LSP and NVIM LSP Config
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                -- Applies options to languages that don't have a custom handler
            })
        end,
        ['lua_ls'] = function() require('lazywave.lsp.lua_ls') end,
    },
})

-- Formatter / linter bridge
require("mason-null-ls").setup({
    ensure_installed = {
        "black",
        "luacheck",
        "pylint",
        "stylua",
        "shfmt",
    },
    automatic_installation = true,
})

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.pylint,
        require("none-ls-luacheck.diagnostics.luacheck"),
    }
})

-- Debug-adapter bridge
require("mason-nvim-dap").setup({
    ensure_installed = {
        "lua",
        "python",
    },
    automatic_installation = true,
    handlers = {
        function(config)
            require("mason-nvim-dap").default_setup(config)
        end,
    },
})

local dap = require("dap")
dap.adapters.python = {
    type = "executable",
    command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
    args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        console = "integratedTerminal",
    },
}
