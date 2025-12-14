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
      },
    },
  },
}
