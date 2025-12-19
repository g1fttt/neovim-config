return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  version = "9.1.0",
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
    },
    formatters = {
      prettier = {
        append_args = { "--no-semi" },
        command = function(self, bufnr)
          local fs = require("conform.fs")
          local util = require("conform.util")

          -- Return type of util.from_node_modules is fun(self: conform.FormatterConfig, ctx: conform.Context): string
          ---@diagnostic disable: redundant-parameter
          return
          -- I'm using bun and it creates prettier.exe in opposite to npm,
          -- which creates prettier.cmd
              util.from_node_modules(fs.is_windows and "prettier.exe" or "prettier")(self, bufnr)
          ---@diagnostic enable
        end,
      },
    },
  },
}
