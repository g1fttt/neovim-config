return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
      theme = "doom",
      config = {
        header = {
          "⠀⠀⠀⢀⣠⣴⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠘⣿⣿⣿⣿⡟⠉⢿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠈⠛⠛⠋⠀⠀⠈⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀",
          "⠀⠀⠀⢠⣾⣿⣿⣿⣿⡟⠁⠘⣿⣿⣿⣿⣷⠀⠀⠀⣀⡀⠀⠀",
          "⠀⠀⣠⣿⣿⣿⣿⣿⠏⠀⠀⠀⢻⣿⣿⣿⣿⡆⣰⣿⣿⣿⣷⡀",
          "⠀⣴⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁",
          "⠰⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⡟⠁⠀",
          "⠀⠙⠻⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⠟⠛⠁⠀⠀⠀",
        },
        center = {
          { desc = "" },
        },
        vertical_center = true,
        disable_move = true,
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    version = "2.0.0",
    opts = {
      progress = {
        display = {
          done_icon = "󰄳",
          overrides = {
            rust_analyzer = { name = "rust-analyzer" },
            lua_ls = { name = "lua-ls" },
            vue_ls = { name = "vue-ls" },
            vtsls = { name = "vue-ts-ls" },
            superhtml = { name = "super-html" },
          },
        },
      },
      notification = {
        window = {
          winblend = 0,
          y_padding = 1,
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local diagnostic_icons = require("lsp").diagnostic_icons

      local theme = require("lualine.themes.auto")
      require("ui.theme").patch_lualine(theme)

      require("lualine").setup({
        options = {
          refresh = {
            refresh_time = 33, -- ~30fps
          },
          theme = theme,
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
            }
          },
          lualine_x = { "filetype" },
        },
      })
    end
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufEnter",
    commit = "337ecfa",
    opts = {
      animation = false,
      clickable = false,
      icons = {
        buffer_index = true,
        button = "",
        separator_at_end = false,
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    cond = function()
      return require("options").extras.transparency
    end,
    opts = {
      extra_groups = {
        "Cursor",
        "NormalFloat",
        "Pmenu",
        "SnippetTabStop",

        "DiagnosticVirtualTextError",
        "DiagnosticVirtualTextWarn",
        "DiagnosticVirtualTextHint",
        "DiagnosticVirtualTextInfo",
      },
      exclude_groups = { "CursorLine", "StatusLine", "StatusLineNC" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = require("mappings").spec,
      delay = 300,
      icons = {
        group = "",
        rules = false,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    version = "2.1.0",
    config = true,
  },
}
