return {
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    version = "*",
    priority = 1000,
    lazy = false,
    config = require("colorschemes.seoulbones").colorscheme_config,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = true,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "2.15.0",
    lazy = false,
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
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    version = "0.11.0",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "rust", "c",
          "cpp", "go",
          "java", "python",
          "lua", "javascript",
          "typescript", "css",
          "html", "tsx",
          "markdown",
        },
        highlight = { enable = true },
      })
    end,
  },
  {
    "ibhagwan/fzf-lua",
    version = "*",
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
    version = "*",
    build = "npm add -g live-server",
    cmd = { "LiveServerToggle" },
    config = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    version = "3.17.0",
    opts = {
      preset = "modern",
      spec = require("mappings"),
      delay = 300,
      icons = {
        group = "",
        rules = false,
      },
    },
  },
  {
    "nvim-mini/mini.completion",
    event = "LspAttach",
    version = "*",
    opts = {
      lsp_completion = { auto_setup = false },
    },
  },
  {
    "NMAC427/guess-indent.nvim",
    event = "BufEnter",
    version = "*",
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
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig" },
  },
}
