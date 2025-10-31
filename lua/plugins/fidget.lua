return {
  "j-hui/fidget.nvim",
  version = "1.6.1",
  opts = {
    progress = {
      display = {
        done_icon = "󰄳",
        overrides = {
          rust_analyzer = { name = "rust-analyzer" },
          lua_ls = { name = "lua-ls" },
          tsserver = { name = "typescript-ls" },
          superhtml = { name = "super-html" },
        },
      },
    },
    notification = {
      window = {
        winblend = 0,
        y_padding = 1,
      },
    },
  },
}
