local utils = require("utils")

local M = {}

function M.colorscheme_config()
  local colorscheme = require(vim.g.colors_name)

  local lush = require("lush")

  local light_palette = {
    CursorLine = { bg = colorscheme.CursorLine.bg.da(5) },
    ColorColumn = { bg = colorscheme.Statement.fg.da(5) },

    DiagnosticUnnecessary = { fg = nil },
    SnippetTabStop = { bg = nil },
  }

  local dark_palette = {
    CursorLine = { bg = colorscheme.CursorLine.bg.da(50) },
    ColorColumn = { bg = colorscheme.Statement.fg.da(50) },

    DiffAdd = { bg = colorscheme.DiffAdd.bg.da(50) },
    DiffDelete = { bg = colorscheme.DiffDelete.bg.da(50) },
    DiffChange = { bg = colorscheme.DiffChange.bg.da(50) },
  }

  local p = vim.opt.background == "dark" and dark_palette or light_palette

  ---@diagnostic disable: undefined-global
  local spec = lush.extends({ colorscheme }).with(function()
    return {
      CursorLine { bg = p.CursorLine.bg },
      ColorColumn { bg = p.ColorColumn.bg },

      DiffAdd { bg = p.DiffAdd and p.DiffAdd.bg or colorscheme.DiffAdd.bg },
      DiffDelete { bg = p.DiffDelete and DiffDelete.bg or colorscheme.DiffDelete.bg },
      DiffChange { bg = p.DiffChange and DiffChange.bg or colorscheme.DiffChange.bg },

      DiagnosticUnnecessary { fg = nil },
      SnippetTabStop { bg = nil },
    }
  end)
  ---@diagnostic enable: undefined-global

  lush(spec)
end

function M.lualine_config(theme)
  local fg_color = utils.is_in_dark_mode()
      and utils.hl_group_color("Identifier").fg
      or "#000000"

  theme.normal.a.fg = fg_color
  theme.normal.a.bg = utils.hl_group_color("Comment").fg

  theme.insert.a.fg = fg_color

  theme.visual.a.fg = fg_color
  theme.visual.a.bg = utils.hl_group_color("Keyword").fg

  theme.replace.a.fg = fg_color

  theme.command.a.fg = fg_color

  theme.inactive.a.fg = fg_color

  return theme
end

function M.hlchunk_config(opts)
  local indent_fg_color = "#000000"
  local chunk_fg_color = "#896788"

  local is_transparent = require("options").extras.transparency

  if utils.is_in_dark_mode() then
    indent_fg_color = "#707070"
    chunk_fg_color = "#BCBCD3"

    if is_transparent then
      indent_fg_color = "#505050"
    end
  else
    indent_fg_color = "#bfbfbf"
  end

  opts.indent.style = { { fg = indent_fg_color } }

  opts.chunk.style = { { fg = chunk_fg_color } }
  opts.line_num.style = { { fg = chunk_fg_color } }
end

return M
