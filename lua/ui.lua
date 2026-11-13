local M = {}

function M.desired_colorscheme()
  local colors_name = (vim.g.colors_name or ""):lower()

  if colors_name == "seoulbones" then
    return require("ui.colorschemes.seoulbones")
  end
end

function M.is_in_dark_mode()
  return vim.o.background == "dark"
end

return M
