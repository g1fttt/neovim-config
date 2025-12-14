local servers_settings = {
  {
    name = "rust_analyzer",
    opts = {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
      root_markers = { "Cargo.toml" },
      settings = {
        checkOnSave = { command = "clippy" },
      },
    },
  },
  {
    name = "lua_ls",
    opts = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json" },
    },
  },
  {
    name = "superhtml",
    opts = {
      cmd = { "superhtml", "lsp" },
      filetypes = { "html", "htm" },
    },
  },
  {
    name = "gopls",
    opts = {
      cmd = { "gopls", "serve" },
      filetypes = { "go" },
    },
  },
  {
    name = "vscode-css-language-server",
    opts = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css" },
    },
  },
  require("lsp.vtsls"),
  require("lsp.vue_ls"),
}

local M = {
  diagnostic_icons = {
    error = "",
    warn = "",
    hint = "",
    info = "",
  },
}

function M.init()
  local diagnostic_config = {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = M.diagnostic_icons.error,
        [vim.diagnostic.severity.WARN]  = M.diagnostic_icons.warn,
        [vim.diagnostic.severity.HINT]  = M.diagnostic_icons.hint,
        [vim.diagnostic.severity.INFO]  = M.diagnostic_icons.info,
      },
    },
    virtual_text = true,
  }

  vim.diagnostic.config(diagnostic_config)

  for _, lsp_value in ipairs(servers_settings) do
    if (type(lsp_value) ~= "table") then
      local utils = require("utils")

      utils.report_error({ "The provided lsp is not a table:", lsp_value })
    end

    vim.lsp.config[lsp_value.name] = lsp_value.opts
    vim.lsp.enable(lsp_value.name)
  end

  -- LSP completion window
  local pum_dimension = 10
  vim.opt.pumheight = pum_dimension
  vim.opt.pumwidth = pum_dimension
end

return M
