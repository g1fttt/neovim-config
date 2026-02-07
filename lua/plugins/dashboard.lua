local M = {
  "nvimdev/dashboard-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  opts = {
    theme = "doom",
    config = {
      header = {
        "⠀⠀⠀⢀⣠⣴⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠘⣿⣿⣿⣿⡟⠉⢿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠈⠛⠛⠋⠀⠀⠈⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢠⣾⣿⣿⣿⣿⡟⠁⠘⣿⣿⣿⣿⣷⠀⠀⠀⣀⡀⠀⠀",
        "⠀⠀⣠⣿⣿⣿⣿⣿⠏⠀⠀⠀⢻⣿⣿⣿⣿⡆⣰⣿⣿⣿⣷⡀",
        "⠀⣴⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁",
        "⠰⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⡟⠁⠀",
        "⠀⠙⠻⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⠟⠛⠁⠀⠀⠀",
      },
      center = {
        { desc = "" },
      },
      vertical_center = true,
    },
  },
}

-- https://github.com/LazyVim/LazyVim/discussions/3901
function M.on_buf_delete_post(ev)
  local deleted_buf_name = vim.api.nvim_buf_get_name(ev.buf)
  local deleted_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
  local deleted_buf_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })

  local is_last_buf_closed = deleted_buf_name == ""
      and deleted_buf_ft == ""
      and deleted_buf_bt == ""

  if is_last_buf_closed then
    vim.cmd("Dashboard")
  end
end

return M
