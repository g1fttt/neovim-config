local M = {}

function M.apply(opts)
  local lush = require("lush")
  local base = require("seoulbones")

  local is_dark = vim.o.background == "dark"
  local factor = is_dark and 50 or 5

  ---@diagnostic disable: undefined-global
  local spec = lush.extends({ base }).with(function()
    return {
      ColorColumn { bg = base.Statement.fg.da(factor) },

      DiffAdd { bg = is_dark and base.DiffAdd.bg.da(factor) or base.DiffAdd.bg },
      DiffDelete { bg = is_dark and base.DiffDelete.bg.da(factor) or base.DiffDelete.bg },
      DiffChange { bg = is_dark and base.DiffChange.bg.da(factor) or base.DiffChange.bg },

      DiagnosticUnnecessary { fg = nil },
      SnippetTabStop { bg = nil },

      SnacksPickerDir { fg = base.Constant.fg },

      IndentGuide { fg = is_dark and "#707070" or "#000000" },
      IndentChunk { fg = is_dark and "#BCBCD3" or "#896788" },

      NormalFloat { bg = opts.tranparent and "NONE" or base.NormalFloat.bg },
    }
  end)
  ---@diagnostic enable: undefined-global

  return lush(spec)
end

function M.lualine(theme, compiled)
  local is_dark = vim.o.background == "dark"
  local fg_color = is_dark and compiled.Identifier.fg.hex or "#000000"

  for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive" }) do
    if theme[mode] and theme[mode].a then
      theme[mode].a.fg = fg_color
    end
  end

  theme.normal.a.bg = compiled.Comment.fg.hex
  theme.visual.a.bg = compiled.Keyword.fg.hex

  return theme
end

return M
