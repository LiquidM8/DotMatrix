-- tweak floating-doc look
local border     = 'rounded'
local max_width  = 80

local util = vim.lsp.util
local _open = util.open_floating_preview
function util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border    = opts.border    or border
  opts.max_width = opts.max_width or max_width
  return _open(contents, syntax, opts, ...)
end

-- Gruvbox-flavoured colors (tweak to taste)
vim.api.nvim_set_hl(0, 'NormalFloat', { fg = '#ebdbb2', bg = '#282828' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#fabd2f', bg = '#282828' })
