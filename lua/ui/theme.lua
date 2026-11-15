local M = {}

local state = {
  spec = nil,
  compiled = nil,
}

local function load_spec(name)
  local ok, spec = pcall(require, "ui.schemes." .. name:lower())
  local default = require("ui.schemes.default")
  return ok and vim.tbl_deep_extend("force", default, spec) or default
end

function M.apply()
  local name = vim.g.colors_name or "default"
  local spec = load_spec(name)
  local opts = {
    transparent = require("options").extras.transparency,
  }

  state.spec = spec

  if spec.apply then
    -- Lush themes
    state.compiled = spec.apply(opts)
  else
    -- Regular themes
    state.compiled = nil
    local palette = spec.palette(opts)
    for group, settings in pairs(spec.highlights(palette, opts)) do
      vim.api.nvim_set_hl(0, group, settings)
    end
  end

  if package.loaded["lualine"] then
    require("lualine").refresh()
  end
end

function M.patch_lualine(theme)
  if state.spec and state.spec.lualine then
    return state.spec.lualine(theme, state.compiled)
  end
  return theme
end

function M.setup()
  local group = vim.api.nvim_create_augroup("UserThemeEngine", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = M.apply,
  })
end

return M
