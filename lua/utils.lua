local M = {}

function M.report_error(msg)
  vim.api.nvim_echo({ { unpack(msg), "ErrorMsg" } }, true, { err = true })
end

function M.hl_group_color(hl_group_name)
  local to_hex = function(rgb_color)
    if rgb_color == nil then
      return nil
    end

    return string.format("#%X", rgb_color)
  end

  local hl_group_color = vim.api.nvim_get_hl(0, { name = hl_group_name })

  return {
    fg = to_hex(hl_group_color.fg),
    bg = to_hex(hl_group_color.bg),
  }
end

function M.desired_colorscheme()
  if vim.g.colors_name == "seoulbones" then
    return require("colorschemes.seoulbones")
  end
end

return M
