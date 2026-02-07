return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    priority = 1000,
    lazy = false,
    config = require("colorschemes.seoulbones").colorscheme_config,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "2.15.0",
    cmd = { "Oil" },
    opts = {
      columns = { "icon", "size" },
      buf_options = { bufhidden = "wipe" },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == ".git"
        end
      },
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "1.9.1",
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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local opts = {
        line_num = { enable = true },
        indent = { enable = true },
        chunk = {
          enable = true,
          duration = 0,
          delay = 0,
        },
      }
      local utils = require("utils")

      utils.desired_colorscheme().hlchunk_config(opts)

      require("hlchunk").setup(opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      ---@diagnostic disable: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "rust", "c",
          "cpp", "go",
          "java", "python",
          "lua", "javascript",
          "typescript", "css",
          "html", "tsx",
          "markdown", "vue",
        },
        highlight = { enable = true },
      })
      ---@diagnostic enable
    end,
  },
  {
    "ibhagwan/fzf-lua",
    config = function()
      local fzf = require("fzf-lua")

      fzf.register_ui_select()

      fzf.setup({
        files = { follow = true },
      })
    end
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "bun install -g live-server",
    cmd = { "LiveServerToggle" },
    init = function()
      vim.g.is_live_server_active = false
    end,
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = require("mappings").spec,
      delay = 300,
      icons = {
        group = "",
        rules = false,
      },
    },
  },
  {
    "saghen/blink.cmp",
    event = "LspAttach",
    version = "1.7.0",
    opts = {
      keymap = require("mappings").blink_cmp(),
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },
      sources = {
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
  {
    "NMAC427/guess-indent.nvim",
    event = "BufEnter",
    opts = {
      buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
        "oil",
        "fidget",
      },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    opts = {
      lazy_load = true,
      user_default_options = {
        names = false,
        css = true,
        tailwind = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    version = "2.28.0",
    opts = {
      lazygit = { enabled = true },
    },
  },
  {
    "Bekaboo/deadcolumn.nvim",
    version = "1.0.2",
    opts = {
      scope = function()
        if vim.fn.mode():find("^[iRss\x13]") ~= nil then
          return vim.fn.strdisplaywidth(vim.fn.getline("."))
        end

        return 0
      end,
      blending = {
        colorcode = require("utils").hl_group_color("CursorLine").bg,
      },
      warning = { alpha = 0.2 },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    version = "8.10.0",
    opts = {
      code = {
        language = false,
        highlight_border = false,
        disable_background = true,
      },
      completions = {
        lsp = { enabled = true },
      },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = { enable_autocmd = false },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
      },
    },
  },
}
