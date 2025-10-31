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
        lualine_x = { "encoding", "filetype" },
      },
    })
  end
}
