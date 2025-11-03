return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  version = "9.1.0",
  opts = {
    formatters_by_ft = {
      rust = { "rustfmt" },

      html = { "superhtml" },
      htm = { "superhtml" },

      css = { "prettier" },

      javascript = { "prettier" },
      typescript = { "prettier" },
    },
    formatters = {
      prettier = {
        append_args = { "--no-semi" },
      },
    },
    default_format_opts = { lsp_format = "fallback" },
  },
}
