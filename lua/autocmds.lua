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
    event = "LspAttach",
    opts = {
      callback = function(ev)
        require("lsp").on_lsp_attach(ev)
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
