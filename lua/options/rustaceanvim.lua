return {
  server = {
    on_attach = require("mappings").on_rust_analyzer_attach,
    default_settings = {
      ["rust-analyzer"] = {},
    },
  },
  dap = {},
}
