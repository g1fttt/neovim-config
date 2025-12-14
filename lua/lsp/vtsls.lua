return {
  name = "vtsls",
  opts = {
    cmd = { "vtsls", "--stdio" },
    filetypes = { "javascript", "typescript", "vue" },
    root_markers = { "package.json" },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = "always" },
      },
    },
    on_attach = function(client)
      if vim.bo.filetype == 'vue' then
        client.server_capabilities.semanticTokensProvider.full = false
      else
        client.server_capabilities.semanticTokensProvider.full = true
      end
    end,
  },
}
