return {
  {
    "FylerOrg/fyler.nvim",
    commit = "8fe34a3",
    opts = {
      kind = "floating",
      integrations = { icon = "nvim_web_devicons" },
      ui = {
        hidden_items = {
          always_visible = { ".gitignore", ".env", ".env.example", ".prettierrc.json", ".vscode" },
          always_hidden = { "node_modules" },
        },
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
      local utils = require("utils")
      local opts = {
        line_num = {
          enable = true,
          style = { utils.hl_group_color("IndentChunk") },
        },
        indent = {
          enable = true,
          style = { utils.hl_group_color("IndentGuide") },
        },
        chunk = {
          enable = true,
          duration = 0,
          delay = 0,
          style = { utils.hl_group_color("IndentChunk") },
        },
      }

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
        "sql", "odin",
        "scss", "tera",
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
    build = "npm install -g live-server",
    cmd = { "LiveServerToggle" },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.lib" },
    event = "LspAttach",
    commit = "86cfb6b",
    build = function()
      require("blink.cmp").build():pwait()
    end,
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
        "fidget",
      },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    ft = { "css", "scss", "html" },
    opts = {
      filetypes = { "css", "scss", "html" },
      lazy_load = true,
      options = {
        parsers = {
          css = true,
          sass = { enable = true },
        },
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
    event = "BufEnter",
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
    opts = {
      enable_autocmd = false,
      languages = {
        c = "// %s",
      },
    },
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
    "smoka7/hop.nvim",
    event = "BufEnter",
    version = "2.7.2",
    config = true,
  },
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    version = "9.0.5",
    lazy = false,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    commit = "dca1a19",
    opts = {
      formatters_by_ft = {
        lua = { lsp_format = "fallback" },

        rust = { "rustfmt" },

        html = { "superhtml" },
        htm = { "superhtml" },

        css = { "prettier" },

        javascript = { "prettier" },
        typescript = { "prettier" },

        vue = { "prettier" },

        go = { "gofmt" },

        odin = { "odinfmt" },
      },
      formatters = {
        prettier = {
          append_args = { "--no-semi" },
          command = function(self, bufnr)
            local fs = require("conform.fs")
            local util = require("conform.util")

            -- Return type of util.from_node_modules is fun(self: conform.FormatterConfig, ctx: conform.Context): string
            ---@diagnostic disable: redundant-parameter
            -- I'm using bun and it creates prettier.exe in opposite to npm, which creates prettier.cmd
            return util.from_node_modules(fs.is_windows and "prettier.exe" or "prettier")(self, bufnr)
            ---@diagnostic enable
          end,
        },
      },
    },
  }
}
