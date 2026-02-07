return {
  {
    event = "BufDelete",
    opts = {
      callback = function()
        vim.schedule(function()
          vim.api.nvim_exec_autocmds("User", { pattern = "BufDeletePost" })
        end)
      end,
    },
  },
  {
    event = "BufWritePre",
    opts = {
      callback = function(ev)
        require("conform").format({ bufnr = ev.buf })
      end,
    },
  },
  {
    event = "BufRead",
    opts = {
      callback = function(ev)
        local buf_type = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
        if buf_type ~= "oil" then
          -- Fix tabs being hidden after closing them
          vim.api.nvim_set_option_value("buflisted", true, { buf = ev.buf })
        end
      end,
    },
  },
  {
    event = "LspAttach",
    opts = {
      callback = function()
        require("mappings").on_lsp_attach()
      end,
    }
  },
  {
    event = "User",
    opts = {
      pattern = "BufDeletePost",
      callback = function(ev)
        require("plugins.dashboard").on_buf_delete_post(ev)
      end,
    },
  },
}
