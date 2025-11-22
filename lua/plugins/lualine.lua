local function live_server_status()
  return vim.g.is_live_server_active and "󱜠 Online" or "󱜡 Offline"
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local theme = require("lualine.themes.auto")
    local utils = require("utils")

    utils.desired_colorscheme().lualine_config(theme)

    local diagnostic_icons = require("lsp").diagnostic_icons

    require("lualine").setup({
      options = {
        theme = theme,
        refresh = {
          refresh_time = 33, -- ~30fps
        },
      },
      sections = {
        lualine_b = {
          "encoding",
          {
            "diagnostics",
            sections = { "error", "warn" },
            symbols = {
              error = diagnostic_icons.error .. " ",
              warn = diagnostic_icons.warn .. " ",
              info = diagnostic_icons.info .. " ",
              hint = diagnostic_icons.hint .. " ",
            },
            update_in_insert = true,
          }
        },
        lualine_x = { live_server_status, "filetype" },
      },
    })
  end
}
