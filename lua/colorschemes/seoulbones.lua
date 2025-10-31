local utils = require("utils")

local M = {}

function M.colorscheme_config()
  vim.g.seoulbones_transparent_background = true

  local colorscheme = require(vim.g.colors_name)

  local lush = require("lush")

  local spec = lush.extends({ colorscheme }).with(function()
    return {
      CursorLine { bg = colorscheme.CursorLine.bg.da(50) },

      NormalFloat { bg = nil },

      DiagnosticUnnecessary { fg = nil },
      DiagnosticVirtualTextError { fg = colorscheme.DiagnosticError.fg, bg = nil },
      DiagnosticVirtualTextWarn { fg = colorscheme.DiagnosticWarn.fg, bg = nil },
      DiagnosticVirtualTextHint { fg = colorscheme.DiagnosticHint.fg, bg = nil },
      DiagnosticVirtualTextInfo { fg = colorscheme.DiagnosticInfo.fg, bg = nil },
    }
  end)

  lush(spec)
end

function M.lualine_config(theme)
  local ident_color = utils.hl_group_color("Identifier")

  theme.normal.a.fg = ident_color.fg
  theme.normal.a.bg = utils.hl_group_color("Comment").fg

  theme.insert.a.fg = ident_color.fg

  theme.visual.a.fg = ident_color.fg
  theme.visual.a.bg = utils.hl_group_color("Keyword").fg

  theme.replace.a.fg = ident_color.fg

  theme.command.a.fg = ident_color.fg

  theme.inactive.a.fg = ident_color.fg

  return theme
end

function M.hlchunk_config(opts)
  local special_color = utils.hl_group_color("Special")

  opts.line_num.style = {{ fg = special_color.fg }}
  opts.indent.style = {{ fg = "#505050" }}
  opts.chunk.style = {{ fg = special_color.fg }}
end

return M
