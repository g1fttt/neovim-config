return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    priority = 1000,
    lazy = false,
    config = require("colorschemes.seoulbones").colorscheme_config,
  },
  {
    "xiyaowong/transparent.nvim",
    cond = function() return require("options").extras.transparency end,
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
    branch = "main",
    init = function()
      local ensure_installed = {
        "rust", "c",
        "cpp", "go",
        "java", "python",
        "lua", "javascript",
        "typescript", "css",
        "html", "tsx",
        "markdown", "vue",
        "sql", "clojure",
        "zig"
      }

      local already_installed = require("nvim-treesitter").get_installed()
      local to_install = vim.iter(ensure_installed)
          :filter(function(parser)
            return not vim.tbl_contains(already_installed, parser)
          end)
          :totable()

      require("nvim-treesitter").install(to_install)
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
    version = "1.10.2",
    opts = {
      keymap = require("mappings").blink_cmp(),
      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
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
    version = "2.31.0",
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
    version = "8.12.0",
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
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    version = "2.1.0",
    config = true,
  },
  {
    "ojroques/nvim-bufdel",
    opts = { quit = false },
  },
  {
    "smoka7/hop.nvim",
    version = "2.7.2",
    config = true,
  },
}
