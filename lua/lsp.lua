local servers_settings = {
  {
    name = "lua_ls",
    opts = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json" },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "Snacks" },
          },
        },
      },
    },
  },
  {
    name = "superhtml",
    opts = {
      cmd = { "superhtml", "lsp" },
      filetypes = { "html" },
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
    name = "zls",
    opts = {
      cmd = { "zls" },
      filetypes = { "zig" },
    },
  },
  {
    name = "vscode-css-language-server",
    opts = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css" },
    },
  },
  {
    name = "pyright",
    opts = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
    },
  },
  {
    name = "clangd",
    opts = {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      filetypes = { "c", "cpp", "cxx" },
    },
  },
  {
    name = "clojure-lsp",
    opts = {
      cmd = { "clojure-lsp", "listen" },
      filetypes = { "clojure" },
      root_markers = { "project.clj" },
    },
  },
  require("lsp.vtsls"),
  require("lsp.vue_ls"),
}

local function setup_diagnostic_handlers()
  local orig_vt_handler = vim.diagnostic.handlers.virtual_text

  vim.diagnostic.handlers.virtual_text = {
    show = function(namespace, bufnr, diags, opts)
      -- Diagnostics from all possible sources in one table
      local true_all_diags = {}

      for _, diag in ipairs(vim.diagnostic.get(bufnr)) do
        if diag.namespace ~= namespace then
          table.insert(true_all_diags, diag)
        end
      end

      for _, diag in ipairs(diags) do
        table.insert(true_all_diags, diag)
      end

      local line_data = {}

      for _, diag in ipairs(true_all_diags) do
        local lnum = diag.lnum

        if not line_data[lnum] then
          line_data[lnum] = { best = diag, count = 1 }
        else
          line_data[lnum].count = line_data[lnum].count + 1

          local best = line_data[lnum].best

          -- Smaller means more severe:
          -- Error = 1
          -- ...
          -- Info = 3
          if diag.severity < best.severity then
            line_data[lnum].best = diag
          elseif diag.severity == best.severity then
            -- Longer message might mean something more important...
            if diag.message > best.message then
              line_data[lnum].best = diag
            end
          end
        end
      end

      local filtered_diags = {}

      for _, diag in ipairs(diags) do
        local lnum = diag.lnum

        if line_data[lnum].best == diag then
          diag._total_count = line_data[lnum].count
          table.insert(filtered_diags, diag)
        end
      end

      orig_vt_handler.show(namespace, bufnr, filtered_diags, opts)
    end,
    hide = orig_vt_handler.hide,
  }
end

local M = {
  diagnostic_icons = {
    error = "",
    warn = "",
    info = "",
    hint = "",
    virtual_text_prefix = "",
  },
}

function M.init()
  setup_diagnostic_handlers()

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = M.diagnostic_icons.error,
        [vim.diagnostic.severity.WARN]  = M.diagnostic_icons.warn,
        [vim.diagnostic.severity.INFO]  = M.diagnostic_icons.info,
        [vim.diagnostic.severity.HINT]  = M.diagnostic_icons.hint,
      },
    },
    virtual_text = {
      spacing = 2,
      source = false,
      prefix = function(diag)
        ---@diagnostic disable-next-line: undefined-field
        return string.rep(M.diagnostic_icons.virtual_text_prefix, diag._total_count)
      end,
      severity = { min = vim.diagnostic.severity.WARN },
    },
    severity_sort = true,
  })

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
