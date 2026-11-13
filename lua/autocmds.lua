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
      callback = function()
        require("mappings").on_lsp_attach()
      end,
    }
  },
  {
    event = "FileType",
    opts = {
      callback = function()
        pcall(vim.treesitter.start)

        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end,
    },
  },
  {
    event = "User",
    opts = {
      -- https://github.com/LazyVim/LazyVim/discussions/3901
      pattern = "BufDeletePost",
      callback = function(ev)
        local deleted_buf_name = vim.api.nvim_buf_get_name(ev.buf)
        local deleted_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
        local deleted_buf_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })

        local is_last_buf_closed = deleted_buf_name == ""
            and deleted_buf_ft == ""
            and deleted_buf_bt == ""

        if is_last_buf_closed then
          vim.cmd("Dashboard")
        end
      end,
    },
  },
}
