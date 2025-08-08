-- plugins/specs/completion.lua  (Lazy spec example)
return {
  { 'L3MON4D3/LuaSnip',            dependencies = { 'rafamadriz/friendly-snippets' } },
  { 'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>']      = cmp.mapping.confirm { select = false },
          ['<Tab>']     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip'  },
          { name = 'path'     },
          { name = 'buffer'   },
        },
      }
    end,
  },
}
