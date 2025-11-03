local utils = require("utils")

local function set_editor_options(options)
  for scope_name, scope_value in pairs(options) do
    if (type(scope_value) ~= "table") then
      utils.report_error({ "The provided option is not a table:", scope_value })
    end

    for option_name, option_value in pairs(scope_value) do
      vim[scope_name][option_name] = option_value
    end
  end
end

local function create_editor_autocmds(autocmds)
  for _, autocmd_value in ipairs(autocmds) do
    if (type(autocmd_value) ~= "table") then
      utils.report_error({ "The provided autocmd is not a table:", autocmd_value })
    end

    vim.api.nvim_create_autocmd(autocmd_value.event, autocmd_value.opts)
  end
end

local function handle_lazy_plugin_manager(plugins_specs)
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazy_path) then
    local lazy_repo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
      "git", "clone", "--filter=blob:none", "--branch=stable",
      lazy_repo, lazy_path
    })

    if vim.v.shell_error ~= 0 then
      utils.report_error({ "Failed to clone lazy.nvim", out })
    end
  end

  vim.opt.rtp:prepend(lazy_path)

  local specs = vim.iter(plugins_specs)
      :map(function(plugin_spec) return { import = plugin_spec } end)
      :totable()

  require("lazy").setup({
    spec = specs,
    install = { colorscheme = { vim.g.colors_name } },
    ui = { border = vim.o.winborder },
  })
end

set_editor_options(require("options"))
create_editor_autocmds(require("autocmds"))

require("lsp").init()

handle_lazy_plugin_manager({
  "plugins",
  "plugins.lualine",
  "plugins.dashboard",
  "plugins.fidget",
  "plugins.conform",
})
