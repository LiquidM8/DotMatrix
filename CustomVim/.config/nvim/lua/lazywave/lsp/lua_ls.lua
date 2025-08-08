-- lua_ls.lua – Lua language‑server configuration for Neovim
-- Keeps Mason/LSP provisioning separate: this file ONLY sets up lua‑ls.
-- Drop it at: lua/lazywave/lsp/lua_ls.lua (or similar) and reference it from
-- your mason‑lspconfig handlers.

---------------------------------------------------------------------
-- 1. nvim‑cmp capabilities (optional)
---------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

---------------------------------------------------------------------
-- 2. Buffer‑local keymaps & format‑on‑save
---------------------------------------------------------------------
local function on_attach(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("gd", vim.lsp.buf.definition,        "Go to Definition")
  nmap("K",  vim.lsp.buf.hover,             "Hover Documentation")
  nmap("<leader>rn", vim.lsp.buf.rename,     "Rename Symbol")
  nmap("gr", vim.lsp.buf.references,        "List References")

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

---------------------------------------------------------------------
-- 3. Upstream default on_init patch (workspace & runtime tweaks)
---------------------------------------------------------------------
local function on_init(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath("config")
      and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
    then
      return
    end
  end

  client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
    runtime = {
      version = "LuaJIT",
      path = {
        "lua/?.lua",
        "lua/?/init.lua",
      },
    },
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
      },
    },
  })
end

---------------------------------------------------------------------
-- 4. lspconfig setup for lua_ls
---------------------------------------------------------------------
local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
if ok_lspconfig then
  lspconfig.lua_ls.setup {
    on_init = on_init,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
            globals = { "vim" },
            disable = { "duplicate-set-field" },
        },
        telemetry   = { enable = false },
        format      = { enable = true },
      },
    },
  }
end

---------------------------------------------------------------------
-- 5. Rounded popup borders (optional eye‑candy)
---------------------------------------------------------------------
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

return {}
